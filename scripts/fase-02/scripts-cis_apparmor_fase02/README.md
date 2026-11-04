<!-- gerado por `make docs` (tools/gendocs) a partir de configs/profiles — não edite à mão -->
# Fase 02 — AppArmor (1.3.x)

Perfil [`ubuntu_22.04_fase02_apparmor`](../../../configs/profiles/ubuntu_22.04_fase02_apparmor.yaml) · 4 controles.

```bash
make audit_fase02_apparmor                     # audita o perfil e gera o HTML em results/
make audit_id ID=1.3.1           # audita um controle
sudo make fix_id ID=1.3.1        # aplica a remediação de um controle
```

> `auditoria/` só lê o sistema. `remediacao/` **altera** o sistema: leia o script e teste numa VM antes de usar em produção.

| ID | Controle | Categoria | Server | Workstation | Auditoria | Remediação |
|---|---|---|:-:|:-:|:-:|:-:|
| 1.3.1 | Ensure AppArmor is installed | AppArmor Configuration | L1 | L1 | [audit](auditoria/1.3.1_ensure_apparmor_is_installed_audit.sh) | [fix](remediacao/1.3.1_ensure_apparmor_is_installed_fix.sh) |
| 1.3.2 | Ensure AppArmor is enabled in the bootloader | AppArmor Configuration | L1 | L1 | [audit](auditoria/1.3.2_ensure_apparmor_is_enabled_in_the_bootloader_audit.sh) | [fix](remediacao/1.3.2_ensure_apparmor_is_enabled_in_the_bootloader_fix.sh) |
| 1.3.3 | Ensure all AppArmor profiles are in enforce or complain mode | AppArmor Configuration | L1 | L1 | [audit](auditoria/1.3.3_ensure_all_apparmor_profiles_are_in_enforce_or_complain_mode_audit.sh) | [fix](remediacao/1.3.3_ensure_all_apparmor_profiles_are_in_enforce_or_complain_mode_fix.sh) |
| 1.3.4 | Ensure all AppArmor profiles are enforced | AppArmor Configuration | L1 | L1 | [audit](auditoria/1.3.4_ensure_all_apparmor_profiles_are_enforced_audit.sh) | [fix](remediacao/1.3.4_ensure_all_apparmor_profiles_are_enforced_fix.sh) |
