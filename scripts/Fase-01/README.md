<!-- gerado por `make docs` (tools/gendocs) a partir de configs/profiles — não edite à mão -->
# Fase 01 — Bootloader, memória, SSH e autenticação

Perfil [`ubuntu_22.04_fase01`](../../configs/profiles/ubuntu_22.04_fase01.yaml) · 8 controles.

```bash
make audit                     # audita o perfil e gera o HTML em results/
make audit_id ID=1.4.1           # audita um controle
sudo make fix_id ID=1.4.1        # aplica a remediação de um controle
```

> `auditoria/` só lê o sistema. `remediacao/` **altera** o sistema: leia o script e teste numa VM antes de usar em produção.

| ID | Controle | Categoria | Server | Workstation | Auditoria | Remediação |
|---|---|---|:-:|:-:|:-:|:-:|
| 1.4.1 | Ensure a password is set on the bootloader | Bootloader Configuration | L1 | L1 | [audit](auditoria/1.4.1_bootloader_audit.sh) | [fix](remediacao/1.4.1_bootloader_fix.sh) |
| 1.5.1 | Ensure Address Space Layout Randomization (ASLR) is enabled | Memory Protection | L1 | L1 | [audit](auditoria/1.5.1_enabled_audit.sh) | [fix](remediacao/1.5.1_enabled_fix.sh) |
| 1.5.3 | Ensure core dumps are restricted | Memory Protection | L1 | L1 | [audit](auditoria/1.5.3_restricted_audit.sh) | [fix](remediacao/1.5.3_restricted_fix.sh) |
| 5.1.20 | Ensure SSH root login is disabled | SSH Configuration | L1 | L1 | [audit](auditoria/5.1.20_disabled_audit.sh) | [fix](remediacao/5.1.20_disabled_fix.sh) |
| 5.1.4 | Ensure SSH root authentication is disabled | SSH Configuration | L1 | L1 | [audit](auditoria/5.1.4_disabled_audit.sh) | [fix](remediacao/5.1.4_disabled_fix.sh) |
| 5.1.19 | Ensure SSH does not allow empty passwords | SSH Configuration | L1 | L1 | [audit](auditoria/5.1.19_passwords_audit.sh) | [fix](remediacao/5.1.19_passwords_fix.sh) |
| 5.2.7 | Ensure access to the 'su' command is restricted | User Access | L1 | L1 | [audit](auditoria/5.2.7_restricted_audit.sh) | [fix](remediacao/5.2.7_restricted_fix.sh) |
| 5.4.1.4 | Ensure password hashing algorithm is SHA-512 | Authentication | L1 | L1 | [audit](auditoria/5.4.1.4_sha_512_audit.sh) | [fix](remediacao/5.4.1.4_sha_512_fix.sh) |
