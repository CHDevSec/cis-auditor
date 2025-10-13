package main

import (
	"flag"
	"fmt"
	"log"
	"os"
	"path/filepath"
	"time"

	"cis-auditor/internal/auditor"
)

func main() {
	// Configuração de flags
	profile := flag.String("profile", "", "Nome do perfil CIS (ex: ubuntu_22.04)")
	machineType := flag.String("type", "server", "Tipo de máquina (server/workstation)")
	level := flag.Int("level", 1, "Nível de auditoria (1 ou 2)")
	profilesDir := flag.String("profiles-dir", "configs/profiles", "Diretório de perfis CIS")
	scriptsDir := flag.String("scripts-dir", "scripts", "Diretório de scripts")
	resultsDir := flag.String("results-dir", "results", "Diretório de resultados")
	flag.Parse()

	// Obter caminhos absolutos
	absProfilesDir, _ := filepath.Abs(*profilesDir)
	absScriptsDir, _ := filepath.Abs(*scriptsDir)
	absResultsDir, _ := filepath.Abs(*resultsDir)

	// Criar auditor
	audit, err := auditor.New(auditor.Config{
		ProfilesDir: absProfilesDir,
		ScriptsDir:  absScriptsDir,
		ResultsDir:  absResultsDir,
	})
	if err != nil {
		log.Fatalf("❌ Erro ao criar auditor: %v", err)
	}

	// Executar auditoria
	report, err := audit.Run(*profile, *machineType, *level)
	if err != nil {
		log.Fatalf("❌ Erro ao executar auditoria: %v", err)
	}

	// Obter hostname
	hostname, _ := os.Hostname()
	timestamp := time.Now().Format("20060102-150405")

	// Caminho do JSON de saída
	jsonFile := filepath.Join(*resultsDir, fmt.Sprintf("audit-results-%s-%s.json", hostname, timestamp))

	// Salvar resultados em JSON
	err = auditor.SaveResultsToJSON(report.ControlResults, jsonFile)
	if err != nil {
		log.Printf("⚠️ Erro ao salvar resultados JSON: %v", err)
	} else {
		log.Printf("✔ Resultados JSON salvos em: %s", filepath.Clean(jsonFile))
	}

	// Mostrar resumo no console
	log.Printf("\n=== RESUMO DA AUDITORIA ===")
	log.Printf("Perfil: %s", report.Profile)
	log.Printf("Tipo: %s | Nível: %d", report.MachineType, report.Level)
	log.Printf("Controles verificados: %d", report.Total)
	log.Printf("✅ Aprovados: %d", report.Passed)
	log.Printf("❌ Falhas: %d", report.Failed)
	log.Printf("⚠️ Erros: %d", report.Errors)
	log.Printf("📄 Relatório HTML gerado em: %s/cis-audit-report.html", filepath.Clean(report.ResultsDir))
}
