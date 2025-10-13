# CIS Ubuntu 22.04 LTS - Hardening 2.1.x

Este pacote contém scripts de **auditoria** e **remediação** automatizados em Bash com base no benchmark CIS Ubuntu 22.04 LTS, seção **2.1.x - Configure Server Services**.

## Estrutura

```
scripts/
├── auditoria/
└── remediacao/
```

## Como usar

### Auditoria

Execute os scripts dentro da pasta `auditoria/` para verificar a conformidade de cada serviço:

```bash
bash scripts/auditoria/2.1.1_ensure_autofs_services_are_not_in_use_audit.sh
```

### Remediação

Execute os scripts dentro da pasta `remediacao/` para aplicar as correções recomendadas:

```bash
bash scripts/remediacao/2.1.1_ensure_autofs_services_are_not_in_use_fix.sh
```

⚠️ **Recomenda-se executar os scripts com privilégios de root.**
