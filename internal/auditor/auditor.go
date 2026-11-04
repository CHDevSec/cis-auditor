package auditor

import (
	"encoding/json"
	"errors"
	"fmt"
	"os"
	"os/exec"
	"path/filepath"
	"runtime"
	"strings"
	"sync"
	"time"

	"gopkg.in/yaml.v3"
)

type auditorImpl struct {
	cfg Config
}

func New(cfg Config) (*auditorImpl, error) {
	if err := os.MkdirAll(cfg.ResultsDir, 0755); err != nil {
		return nil, fmt.Errorf("failed to create results directory: %w", err)
	}
	if cfg.Workers <= 0 {
		cfg.Workers = runtime.NumCPU()
	}
	return &auditorImpl{cfg: cfg}, nil
}

func (a *auditorImpl) Run(profile, machineType string, level int) (*Report, error) {
	if machineType != "server" && machineType != "workstation" {
		return nil, fmt.Errorf("tipo de máquina inválido: %s (use 'server' ou 'workstation')", machineType)
	}

	hostname, _ := os.Hostname()
	profilePath := filepath.Join(a.cfg.ProfilesDir, profile+".yaml")

	prof, err := LoadProfile(profilePath)
	if err != nil {
		return nil, fmt.Errorf("erro ao carregar controles: %w", err)
	}
	// sem --scripts-dir, usa a pasta declarada no perfil (relativa ao diretório atual)
	if a.cfg.ScriptsDir == "" {
		if prof.ScriptsDir == "" {
			return nil, fmt.Errorf("o perfil %s não declara scripts_dir: informe --scripts-dir", profile)
		}
		if a.cfg.ScriptsDir, err = filepath.Abs(prof.ScriptsDir); err != nil {
			return nil, err
		}
	}
	controls := a.selectControls(prof.Controls, machineType, level)

	results := a.executeControls(controls)

	return &Report{
		Profile:        profile,
		MachineType:    machineType,
		Level:          level,
		Hostname:       hostname,
		Timestamp:      time.Now().Format(time.RFC3339),
		Total:          len(results),
		Passed:         countResults(results, StatusPass),
		Failed:         countResults(results, StatusFail),
		Manual:         countResults(results, StatusManual),
		Errors:         countResults(results, StatusError),
		ResultsDir:     a.cfg.ResultsDir,
		ControlResults: results,
	}, nil
}

// LoadProfile lê um perfil YAML.
func LoadProfile(profilePath string) (*Profile, error) {
	yamlFile, err := os.ReadFile(profilePath)
	if err != nil {
		return nil, fmt.Errorf("erro ao ler arquivo YAML: %w", err)
	}

	var profile Profile
	if err := yaml.Unmarshal(yamlFile, &profile); err != nil {
		return nil, fmt.Errorf("erro ao decodificar YAML: %w", err)
	}
	return &profile, nil
}

// selectControls filtra os controles pelo tipo de máquina e nível, e descarta os que
// não têm script de auditoria na pasta.
func (a *auditorImpl) selectControls(controls []Control, machineType string, level int) []Control {
	var validControls []Control
	for _, control := range controls {
		controlLevel, exists := control.Level[machineType]
		if !exists || controlLevel > level {
			continue
		}

		scriptPath := filepath.Join(a.cfg.ScriptsDir, control.ScriptAudit)
		if _, err := os.Stat(scriptPath); err != nil {
			fmt.Printf("[WARN] Script não encontrado para o controle %s: %s\n", control.ID, scriptPath)
			continue
		}

		validControls = append(validControls, control)
	}

	return validControls
}

// executeControls roda os scripts em paralelo (os de auditoria só leem o sistema) e
// devolve os resultados na mesma ordem do perfil.
func (a *auditorImpl) executeControls(controls []Control) []ControlResult {
	results := make([]ControlResult, len(controls))
	jobs := make(chan int)
	var wg sync.WaitGroup
	for w := 0; w < a.cfg.Workers; w++ {
		wg.Add(1)
		go func() {
			defer wg.Done()
			for i := range jobs {
				result, err := a.executeControl(controls[i])
				if err != nil {
					fmt.Printf("[ERROR] Erro ao executar controle %s: %v\n", controls[i].ID, err)
					result.Status = StatusError
					result.Details = err.Error()
				}
				results[i] = result
			}
		}()
	}
	for i := range controls {
		jobs <- i
	}
	close(jobs)
	wg.Wait()
	return results
}

func (a *auditorImpl) executeControl(control Control) (ControlResult, error) {
	result := ControlResult{
		ID:          control.ID,
		Category:    control.Category,
		Description: control.Description,
		Remediation: control.Remediate,
		FixScript:   a.fixScriptPath(control),
	}

	scriptPath := filepath.Join(a.cfg.ScriptsDir, control.ScriptAudit)
	output, err := a.execCommand(scriptPath)
	if err != nil {
		return result, fmt.Errorf("erro ao executar script: %w", err)
	}

	result.Status, result.Details = parseAuditOutput(output)
	return result, nil
}

// fixScriptPath devolve o script de remediação do controle (pasta "remediacao" ao lado
// da pasta de auditoria), relativo ao diretório atual quando possível.
func (a *auditorImpl) fixScriptPath(control Control) string {
	if control.ScriptFix == "" {
		return ""
	}
	p := filepath.Join(filepath.Dir(a.cfg.ScriptsDir), "remediacao", control.ScriptFix)
	if _, err := os.Stat(p); err != nil {
		return ""
	}
	if wd, err := os.Getwd(); err == nil {
		if rel, err := filepath.Rel(wd, p); err == nil && !strings.HasPrefix(rel, "..") {
			return rel
		}
	}
	return p
}

// execCommand roda o script com bash. Código de saída diferente de zero NÃO é erro:
// vários checks terminam num grep que não encontrou nada, e o veredito vem da saída.
// Só é erro quando o script não pôde ser executado.
func (a *auditorImpl) execCommand(scriptPath string) (string, error) {
	cmd := exec.Command("bash", scriptPath)
	cmd.Env = os.Environ()

	output, err := cmd.CombinedOutput()
	var exitErr *exec.ExitError
	if err != nil && !errors.As(err, &exitErr) {
		return string(output), err
	}
	return string(output), nil
}

var (
	failMarkers = []string{"** FAIL **", "❌", "✘", "✖"}
	passMarkers = []string{"** PASS **", "✅", "✔"}
)

// parseAuditOutput converte a saída de um script em status + detalhes.
// Qualquer linha de falha vence; sem falha e com ao menos uma linha de sucesso é PASS;
// sem nenhum marcador o script só coletou informação e o controle fica MANUAL.
func parseAuditOutput(output string) (status, details string) {
	var notes, info []string
	pass, fail := false, false

	for _, raw := range strings.Split(strings.TrimSpace(output), "\n") {
		line := strings.TrimSpace(raw)
		switch {
		case line == "":
			continue
		case containsAny(line, failMarkers):
			fail = true
			if msg := stripMarkers(line); msg != "" {
				notes = append(notes, msg)
			}
		case containsAny(line, passMarkers):
			pass = true
		case strings.HasPrefix(line, "- "):
			notes = append(notes, strings.TrimPrefix(line, "- "))
		case strings.HasPrefix(line, "Verificando"), strings.HasPrefix(line, "Listando"):
			// cabeçalho do script, não é resultado
		default:
			info = append(info, line)
		}
	}

	switch {
	case fail:
		return StatusFail, strings.Join(notes, "\n")
	case pass:
		return StatusPass, strings.Join(notes, "\n")
	case len(info) > 0:
		return StatusManual, strings.Join(info, "\n")
	default:
		return StatusManual, "O script não retornou saída: revisar manualmente."
	}
}

func containsAny(s string, subs []string) bool {
	for _, sub := range subs {
		if strings.Contains(s, sub) {
			return true
		}
	}
	return false
}

func stripMarkers(line string) string {
	for _, m := range append(failMarkers, passMarkers...) {
		line = strings.ReplaceAll(line, m, "")
	}
	return strings.TrimSpace(line)
}

func countResults(results []ControlResult, status string) int {
	count := 0
	for _, r := range results {
		if r.Status == status {
			count++
		}
	}
	return count
}

// SaveReportJSON grava o relatório completo (metadados, resumo e controles).
func SaveReportJSON(report *Report, outputPath string) error {
	jsonData, err := json.MarshalIndent(report, "", "  ")
	if err != nil {
		return fmt.Errorf("erro ao gerar JSON: %w", err)
	}

	if err := os.WriteFile(outputPath, jsonData, 0644); err != nil {
		return fmt.Errorf("erro ao salvar JSON: %w", err)
	}

	return nil
}
