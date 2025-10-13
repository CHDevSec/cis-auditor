# CIS Benchmark - Ubuntu 22.04 LTS - Fase 01

## Instruções de execução

### Auditoria
Para verificar o estado atual de conformidade dos controles, execute os scripts da pasta `scripts/auditoria`:
```bash
bash scripts/auditoria/1.4.1_bootloader_audit.sh
bash scripts/auditoria/1.5.1_enabled_audit.sh
```

### Remediação
Para aplicar as correções recomendadas:
```bash
sudo bash scripts/remediacao/1.4.1_bootloader_fix.sh
sudo bash scripts/remediacao/1.5.1_enabled_fix.sh
```


bash scripts/auditoria/1.5.3_restricted_audit.sh
bash scripts/auditoria/5.1.20_disabled_audit.sh
bash scripts/auditoria/5.1.4_disabled_audit.sh
bash scripts/auditoria/5.1.19_passwords_audit.sh
bash scripts/auditoria/5.2.7_restricted_audit.sh
bash scripts/auditoria/5.4.1.4_sha_512_audit.sh

sudo bash scripts/remediacao/1.5.3_restricted_fix.sh
sudo bash scripts/remediacao/5.1.20_disabled_fix.sh
sudo bash scripts/remediacao/5.1.4_disabled_fix.sh
sudo bash scripts/remediacao/5.1.19_passwords_fix.sh
sudo bash scripts/remediacao/5.2.7_restricted_fix.sh
sudo bash scripts/remediacao/5.4.1.4_sha_512_fix.sh
