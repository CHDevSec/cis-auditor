# 🔐 CIS Auditor - Hardening Linux na Prática

Automatize auditorias e remediações em sistemas Linux com base no benchmark CIS para Ubuntu 22.04.  
Ideal para ambientes corporativos, consultorias de segurança, treinamentos ou hardening interno.

---

## ⚙️ Requisitos

- Go 1.18 ou superior  
- Python 3+  
- Bash  
- Permissões de execução (`chmod +x`) nos scripts  

---

## 🗂️ Estrutura do Projeto

```
├── cmd/                   # Entrypoint da aplicação (main.go)
├── configs/profiles/      # Perfis YAML (Fase 01 e Fase 02)
├── internal/auditor/      # Lógica principal da auditoria em Go
├── scripts/
│   ├── Fase-01/
│   │   ├── auditoria/     # Scripts de auditoria Fase 01
│   │   └── remediacao/    # Scripts de remediação Fase 01
│   ├── Fase-02/
│   │   ├── auditoria/     # Scripts de auditoria Fase 02
│   │   └── remediacao/    # Scripts de remediação Fase 02
│   └── generate_report.py # Gera HTML a partir do JSON
├── results/               # Saída dos relatórios (JSON + HTML)
├── Makefile               # Automação dos comandos
```

---

## 🚀 Comandos Rápidos (`make`)

### ▶️ Auditorias completas

```bash
make audit            # Executa auditoria da Fase 01 + gera HTML
make audit_fase02     # Executa auditoria da Fase 02 + gera HTML
```

### ▶️ Auditoria individual

```bash
make audit_id ID=1.1.3   # Executa apenas o controle 1.1.3
```

### 🛠️ Remediação

```bash
make fix_id ID=1.1.3     # Executa a remediação do controle 1.1.3
make fix_all             # Executa todas as remediações da Fase 01
```

### 📝 Gerar apenas o relatório HTML

```bash
make report
```

---

## 📦 Exemplo de Execução

```bash
make audit              # Executa auditoria da Fase 01
make fix_id ID=1.5.1    # Executa remediação do controle 1.5.1
```

📄 O relatório HTML será gerado em:

```
results/cis-audit-report.html
```

---

## 👥 Indicado para:

- Times de Infraestrutura, SOC, DevSecOps  
- Auditorias internas e compliance  
- Implantação de baseline seguro em servidores Linux  
- Cursos, treinamentos e e-books de cibersegurança  

---

## 🤝 Contribuições

Este projeto está em constante evolução. Sugestões, melhorias e contribuições são muito bem-vindas!

---

## 👨‍💻 Autor

**Caio Henrique**  
Especialista em Cibersegurança e Engenharia de Software  
