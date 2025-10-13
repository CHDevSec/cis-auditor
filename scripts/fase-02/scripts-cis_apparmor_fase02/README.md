# Scripts de Hardening - CIS Ubuntu 22.04 LTS (Fase 02 - AppArmor)

## Estrutura
- `scripts/auditoria/`: Scripts de auditoria para verificar conformidade com os controles AppArmor.
- `scripts/remediacao/`: Scripts de remediação para aplicar as configurações recomendadas.

## Execução
### Auditoria
```bash
chmod +x scripts/auditoria/*.sh
./scripts/auditoria/1.3.1_ensure_apparmor_is_installed_audit.sh
```

### Remediação
```bash
chmod +x scripts/remediacao/*.sh
sudo ./scripts/remediacao/1.3.1_ensure_apparmor_is_installed_fix.sh
```

**⚠️ Execute os scripts com cautela em ambientes de produção.**

Incluído: `ubuntu_22.04_fase02_apparmor.yaml`
