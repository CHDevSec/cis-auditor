# cis-auditor — auditoria e remediação CIS Benchmark para Ubuntu 22.04
# `make` ou `make help` lista os alvos.

BIN      := bin/cis-auditor
VERSION  := $(shell git describe --tags --always --dirty 2>/dev/null || echo dev)
PROFILES := configs/profiles
RESULTS  := results
TYPE     ?= server
LEVEL    ?= 1


# roda um perfil (a pasta dos scripts vem do scripts_dir do YAML): $(call run_profile,<perfil>)
define run_profile
	@$(BIN) --profile $(1) --type $(TYPE) --level $(LEVEL) \
		--profiles-dir $(PROFILES) --results-dir $(RESULTS) $(EXTRA)
	@python3 scripts/generate_report.py --results-dir $(RESULTS)
endef

.DEFAULT_GOAL := help
.PHONY: help build test lint clean clean-results report \
        audit audit_fase02 audit_fase02_servicos audit_fase02_apparmor audit_fase02_ufw audit_fase02_rede \
        audit_all audit_id fix_id fix_all ci docs

help: ## Lista os alvos
	@awk 'BEGIN {FS = ":.*## "} /^[a-zA-Z0-9_-]+:.*## / {printf "  \033[36m%-24s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

build: ## Compila o binário em bin/
	go build -ldflags "-X main.version=$(VERSION)" -o $(BIN) ./cmd/cis-auditor

test: ## Testes do motor (Go)
	go test ./...

lint: ## go vet + checagem de sintaxe dos scripts
	go vet ./...
	@for f in $$(find scripts -name '*.sh'); do bash -n $$f || exit 1; done && echo "✔ scripts .sh sem erro de sintaxe"
	python3 -m py_compile scripts/generate_report.py

audit: build ## Fase 01: bootloader, memória, SSH, usuários, senhas
	$(call run_profile,ubuntu_22.04_fase01)

audit_fase02_servicos: build ## Fase 02: serviços que não devem estar em uso (2.1.x)
	$(call run_profile,ubuntu_22.04_fase02_servicos)

audit_fase02_apparmor: build ## Fase 02: AppArmor (1.3.x)
	$(call run_profile,ubuntu_22.04_fase02_apparmor)

audit_fase02_ufw: build ## Fase 02: firewall UFW (4.1.x)
	$(call run_profile,ubuntu_22.04_fase02_firewall_ufw)

audit_fase02_rede: build ## Fase 02: parâmetros de rede do kernel (3.3.x)
	$(call run_profile,ubuntu_22.04_fase02_rede)

audit_fase02: audit_fase02_servicos audit_fase02_apparmor audit_fase02_ufw audit_fase02_rede ## Todos os perfis da Fase 02

audit_all: audit audit_fase02 ## Fase 01 + Fase 02 (um JSON por perfil)

ci: EXTRA = --strict
ci: audit ## Fase 01 com --strict: sai com erro se algum controle falhar

docs: ## Regera docs/CONTROLS.md e os README das pastas de scripts a partir dos perfis
	go run ./tools/gendocs

report: ## Gera o HTML a partir do JSON mais recente
	python3 scripts/generate_report.py --results-dir $(RESULTS)

audit_id: ## Audita um controle: make audit_id ID=1.5.1
	@test -n "$(ID)" || (echo "use: make audit_id ID=1.5.1" && exit 1)
	@f=$$(find scripts -path '*auditoria*' -name "$(ID)_*audit.sh" | head -1); \
	test -n "$$f" || (echo "controle $(ID) não encontrado" && exit 1); \
	echo "▶ $$f"; bash "$$f"

fix_id: ## Aplica a remediação de um controle: sudo make fix_id ID=1.5.1
	@test -n "$(ID)" || (echo "use: sudo make fix_id ID=1.5.1" && exit 1)
	@f=$$(find scripts -path '*remediacao*' -name "$(ID)_*fix.sh" | head -1); \
	test -n "$$f" || (echo "remediação de $(ID) não encontrada" && exit 1); \
	echo "▶ $$f"; bash "$$f"

fix_all: ## Aplica TODAS as remediações da Fase 01 (altera o sistema)
	@echo "⚙️  Executando todas as remediações da Fase 01..."
	@for file in $$(find scripts/Fase-01/remediacao -type f -name "*.sh" | sort -V); do \
		echo; echo "Executando $$file..."; \
		bash $$file; \
	done

clean: ## Remove o binário
	rm -rf bin/

clean-results: ## Apaga os JSON/HTML de results/
	@find $(RESULTS)/ -type f \( -name "audit-results-*" -o -name "*.html" \) -delete
	@echo "✅ results/ limpo"
