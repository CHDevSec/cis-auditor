package auditor

import (
	"encoding/json"
	"fmt"
	"os"
	"os/exec"
	"path/filepath"
	"strings"
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
	return &auditorImpl{cfg: cfg}, nil
}

func (a *auditorImpl) Run(profile, machineType string, level int) (*Report, error) {
	if machineType != "server" && machineType != "workstation" {
		return nil, fmt.Errorf("tipo de máquina inválido: %s (use 'server' ou 'workstation')", machineType)
	}

	hostname, _ := os.Hostname()
	profilePath := filepath.Join(a.cfg.ProfilesDir, profile+".yaml")

	controls, err := a.loadProfileControls(profilePath, machineType, level)
	if err != nil {
		return nil, fmt.Errorf("erro ao carregar controles: %w", err)
	}

	results := a.executeControls(controls)

	report := &Report{
		Profile:        profile,
		MachineType:    machineType,
		Level:          level,
		Total:          len(controls),
		Passed:         countResults(results, "PASS"),
		Failed:         countResults(results, "FAIL"),
		Errors:         countResults(results, "ERROR"),
		ResultsDir:     a.cfg.ResultsDir,
		Timestamp:      time.Now().Format("02/01/2006 15:04:05"),
		ControlResults: results,
	}

	if err := a.generateHTMLReport(report, hostname); err != nil {
		return nil, fmt.Errorf("erro ao gerar relatório HTML: %w", err)
	}

	return report, nil
}

func (a *auditorImpl) loadProfileControls(profilePath, machineType string, level int) ([]Control, error) {
	yamlFile, err := os.ReadFile(profilePath)
	if err != nil {
		return nil, fmt.Errorf("erro ao ler arquivo YAML: %w", err)
	}

	var profile struct {
		Controls []Control `yaml:"controls"`
	}
	if err := yaml.Unmarshal(yamlFile, &profile); err != nil {
		return nil, fmt.Errorf("erro ao decodificar YAML: %w", err)
	}

	var validControls []Control
	for _, control := range profile.Controls {
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

	return validControls, nil
}

func (a *auditorImpl) executeControls(controls []Control) []ControlResult {
	var results []ControlResult
	for _, control := range controls {
		result, err := a.executeControl(control)
		if err != nil {
			fmt.Printf("[ERROR] Erro ao executar controle %s: %v\n", control.ID, err)
			result.Status = "ERROR"
			result.Details = err.Error()
		}
		results = append(results, result)
	}
	return results
}

func (a *auditorImpl) executeControl(control Control) (ControlResult, error) {
	result := ControlResult{
		ID:          control.ID,
		Category:    control.Category,
		Description: control.Description,
		Remediation: control.Remediate,
	}

	scriptPath := filepath.Join(a.cfg.ScriptsDir, control.ScriptAudit)
	output, err := a.execCommand(scriptPath)
	if err != nil {
		return result, fmt.Errorf("erro ao executar script: %w", err)
	}

	result.Status, result.Details = parseAuditOutput(output)
	return result, nil
}

func (a *auditorImpl) execCommand(scriptPath string) (string, error) {
	cmd := exec.Command("bash", scriptPath)
	cmd.Env = os.Environ()

	output, err := cmd.CombinedOutput()
	if err != nil {
		return string(output), fmt.Errorf("%v: %s", err, string(output))
	}

	return string(output), nil
}

func parseAuditOutput(output string) (status, details string) {
	lines := strings.Split(strings.TrimSpace(output), "\n")

	for _, line := range lines {
		line = strings.TrimSpace(line)
		switch {
		case strings.Contains(line, "** PASS **"):
			status = "PASS"
		case strings.Contains(line, "** FAIL **"):
			status = "FAIL"
		case strings.HasPrefix(line, "- "):
			details += strings.TrimPrefix(line, "- ") + "\n"
		}
	}

	if status == "" {
		status = "FAIL"
		details = "Formato de saída inválido do script"
	}

	return status, strings.TrimSpace(details)
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

func (a *auditorImpl) generateHTMLReport(report *Report, hostname string) error {
	html := `<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <title>Relatório CIS - ` + report.Profile + `</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 20px;
            line-height: 1.6;
            color: #333;
        }
        .header {
            border-bottom: 1px solid #eee;
            padding-bottom: 10px;
            margin-bottom: 20px;
        }
        .summary {
            background: #f8f9fa;
            padding: 15px;
            border-radius: 5px;
            margin-bottom: 20px;
            display: flex;
            gap: 20px;
            flex-wrap: wrap;
        }
        .passed { color: #28a745; font-weight: bold; }
        .failed { color: #dc3545; font-weight: bold; }
        .error { color: #ffc107; font-weight: bold; }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        th, td {
            padding: 12px 15px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        th {
            background-color: #2c3e50;
            color: white;
        }
        tr:nth-child(even) {
            background-color: #f2f2f2;
        }
        .status-pass { color: #28a745; }
        .status-fail { color: #dc3545; }
        .status-error { color: #ffc107; }
        .remediation {
            font-family: monospace;
            background: #f8f9fa;
            padding: 5px;
            border-radius: 3px;
        }
        .details {
            font-size: 0.9em;
            color: #666;
        }
    </style>
</head>
<body>
    <div class="header">
        <h1>Relatório de Auditoria CIS</h1>
        <p><strong>Hostname:</strong> ` + hostname + ` | <strong>Tipo:</strong> ` + report.MachineType + ` | <strong>Nível:</strong> ` + fmt.Sprint(report.Level) + `</p>
    </div>

    <div class="summary">
        <h3>Resumo</h3>
        <p><span class="passed">✓ Passaram: ` + fmt.Sprint(report.Passed) + `</span> | 
           <span class="failed">✗ Falharam: ` + fmt.Sprint(report.Failed) + `</span> |
           <span class="error">⚠ Erros: ` + fmt.Sprint(report.Errors) + `</span></p>
    </div>

    <h3>Detalhes da Auditoria</h3>
    <table>
        <thead>
            <tr>
                <th>Categoria</th>
                <th>CIS ID</th>
                <th>Status</th>
                <th>Descrição</th>
                <th>Correção</th>
            </tr>
        </thead>
        <tbody>`

	for _, result := range report.ControlResults {
		statusClass := "status-pass"
		switch result.Status {
		case "FAIL":
			statusClass = "status-fail"
		case "ERROR":
			statusClass = "status-error"
		}

		remediation := fmt.Sprintf(`<div class="remediation"><code>bash scripts/Fase-01/remediacao/%s_fix.sh</code></div>`, result.ID)

		html += fmt.Sprintf(`
            <tr>
                <td>%s</td>
                <td>%s</td>
                <td class="%s">%s</td>
                <td>%s<div class="details">%s</div></td>
                <td>%s</td>
            </tr>`,
			result.Category,
			result.ID,
			statusClass,
			result.Status,
			result.Description,
			result.Details,
			remediation)
	}

	html += `
        </tbody>
    </table>
</body>
</html>`

	reportFile := filepath.Join(report.ResultsDir, "cis-audit-report.html")
	if err := os.WriteFile(reportFile, []byte(html), 0644); err != nil {
		return fmt.Errorf("erro ao salvar relatório HTML: %w", err)
	}

	return nil
}

func SaveResultsToJSON(results []ControlResult, outputPath string) error {
	jsonData, err := json.MarshalIndent(results, "", "  ")
	if err != nil {
		return fmt.Errorf("erro ao gerar JSON: %w", err)
	}

	if err := os.WriteFile(outputPath, jsonData, 0644); err != nil {
		return fmt.Errorf("erro ao salvar JSON: %w", err)
	}

	return nil
}
