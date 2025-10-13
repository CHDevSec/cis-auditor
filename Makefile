.PHONY: build run test clean audit report audit_id fix_id fix_all clean-results \
        audit_fase02_servicos audit_fase02_apparmor audit_fase02_ufw audit_fase02_rede

build:
	go build -o bin/cis-auditor ./cmd/cis-auditor

run:
	go run ./cmd/cis-auditor -profile ubuntu_22.04

test:
	go test -v ./...

clean:
	rm -rf bin/

# Executa auditoria CIS da Fase 01 e gera HTML
audit:
	go run ./cmd/cis-auditor \
		--profile ubuntu_22.04_fase01 \
		--type server \
		--level 1 \
		--profiles-dir configs/profiles \
		--scripts-dir scripts/Fase-01/auditoria \
		--results-dir results
	@make report && echo "✅ Relatório Fase 01 gerado com sucesso!"

# Fase 02 - Serviços
audit_fase02_servicos:
	go run ./cmd/cis-auditor \
		--profile ubuntu_22.04_fase02_servicos \
		--type server \
		--level 1 \
		--profiles-dir configs/profiles \
		--scripts-dir scripts/Fase-02/scripts-cis_ubuntu_2.1.x/auditoria \
		--results-dir results
	@make report && echo "✅ Relatório Fase 02 - Serviços gerado com sucesso!"

# Fase 02 - AppArmor
audit_fase02_apparmor:
	go run ./cmd/cis-auditor \
		--profile ubuntu_22.04_fase02_apparmor \
		--type server \
		--level 1 \
		--profiles-dir configs/profiles \
		--scripts-dir scripts/Fase-02/scripts-cis_apparmor_fase02/auditoria \
		--results-dir results
	@make report && echo "✅ Relatório Fase 02 - AppArmor gerado com sucesso!"

# Fase 02 - Firewall UFW
audit_fase02_ufw:
	go run ./cmd/cis-auditor \
		--profile ubuntu_22.04_fase02_firewall_ufw \
		--type server \
		--level 1 \
		--profiles-dir configs/profiles \
		--scripts-dir scripts/Fase-02/scripts-cis_ubuntu_ufw_4.1/auditoria \
		--results-dir results
	@make report && echo "✅ Relatório Fase 02 - UFW gerado com sucesso!"

# Fase 02 - Rede
audit_fase02_rede:
	go run ./cmd/cis-auditor \
		--profile ubuntu_22.04_fase02_rede \
		--type server \
		--level 1 \
		--profiles-dir configs/profiles \
		--scripts-dir scripts/Fase-02/scripts-cis_ubuntu_rede/auditoria \
		--results-dir results
	@make report && echo "✅ Relatório Fase 02 - Rede gerado com sucesso!"

# Gera o relatório HTML a partir do último JSON de auditoria
report:
	python3 scripts/generate_report.py

# Executa auditoria individual por ID
audit_id:
	@echo "Executando auditoria para controle $(ID)..."
	@bash $(shell find scripts/Fase-01/auditoria -type f -name "$(ID)*_audit.sh")

# Executa remediação individual por ID
fix_id:
	@echo "Executando remediação para controle $(ID)..."
	@bash $(shell find scripts/Fase-01/remediacao -type f -name "$(ID)*.sh")

# Executa todas as remediações da Fase 01
fix_all:
	@echo "⚙️ Executando todas as remediações da Fase 01..."
	@for file in $(shell find scripts/Fase-01/remediacao -type f -name "*.sh"); do \
		echo "\nExecutando $$file..."; \
		bash $$file; \
	done

# Limpa apenas os arquivos de resultado JSON
clean-results:
	@echo "🧹 Limpando arquivos JSON antigos da pasta results/..."
	@find results/ -type f -name "audit-results-*" -delete
	@echo "✅ Limpeza concluída!"
