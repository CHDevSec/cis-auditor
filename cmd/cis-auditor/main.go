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

// version é preenchida no build (make build usa a tag do git).
var version = "dev"

func main() {
	// Configuração de flags
	profile := flag.String("profile", "", "Nome do perfil CIS em profiles-dir, sem .yaml (ex: ubuntu_22.04_fase01)")
	machineType := flag.String("type", "server", "Tipo de máquina (server/workstation)")
	level := flag.Int("level", 1, "Nível de auditoria (1 ou 2)")
	profilesDir := flag.String("profiles-dir", "configs/profiles", "Diretório de perfis CIS")
	scriptsDir := flag.String("scripts-dir", "", "Diretório dos scripts de auditoria (padrão: scripts_dir do perfil)")
	resultsDir := flag.String("results-dir", "results", "Diretório de resultados")
	workers := flag.Int("workers", 0, "Scripts executados em paralelo (0 = número de CPUs)")
	strict := flag.Bool("strict", false, "Sai com código 2 se algum controle falhar (para CI)")
	showVersion := flag.Bool("version", false, "Mostra a versão e sai")
	flag.Parse()

	if *showVersion {
		fmt.Println("cis-auditor", version)
		return
	}
	if *profile == "" {
		fmt.Fprintln(os.Stderr, "informe --profile (ex: --profile ubuntu_22.04_fase01)")
		flag.Usage()
		os.Exit(1)
	}

	// Obter caminhos absolutos
	absProfilesDir, _ := filepath.Abs(*profilesDir)
	absScriptsDir := ""
	if *scriptsDir != "" {
		absScriptsDir, _ = filepath.Abs(*scriptsDir)
	}
	absResultsDir, _ := filepath.Abs(*resultsDir)

	// Criar auditor
	audit, err := auditor.New(auditor.Config{
		ProfilesDir: absProfilesDir,
		ScriptsDir:  absScriptsDir,
		ResultsDir:  absResultsDir,
		Workers:     *workers,
	})
	if err != nil {
		log.Fatalf("❌ Erro ao criar auditor: %v", err)
	}

	// Executar auditoria
	start := time.Now()
	report, err := audit.Run(*profile, *machineType, *level)
	if err != nil {
		log.Fatalf("❌ Erro ao executar auditoria: %v", err)
	}

	// Caminho do JSON de saída
	timestamp := time.Now().Format("20060102-150405")
	jsonFile := filepath.Join(*resultsDir, fmt.Sprintf("audit-results-%s-%s-%s.json", report.Hostname, report.Profile, timestamp))

	// Salvar resultados em JSON
	if err := auditor.SaveReportJSON(report, jsonFile); err != nil {
		log.Printf("⚠️ Erro ao salvar resultados JSON: %v", err)
	} else {
		log.Printf("✔ Resultados JSON salvos em: %s", filepath.Clean(jsonFile))
	}

	// Mostrar resumo no console
	log.Printf("=== RESUMO DA AUDITORIA ===")
	log.Printf("Perfil: %s", report.Profile)
	log.Printf("Tipo: %s | Nível: %d", report.MachineType, report.Level)
	log.Printf("Controles verificados: %d em %s", report.Total, time.Since(start).Round(time.Millisecond))
	log.Printf("✅ Aprovados: %d", report.Passed)
	log.Printf("❌ Falhas: %d", report.Failed)
	log.Printf("📝 Revisão manual: %d", report.Manual)
	log.Printf("⚠️ Erros: %d", report.Errors)
	log.Printf("📄 Relatório HTML: python3 scripts/generate_report.py %s", filepath.Clean(jsonFile))

	if *strict && (report.Failed > 0 || report.Errors > 0) {
		os.Exit(2)
	}
}
