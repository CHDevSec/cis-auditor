<!-- gerado por `make docs` (tools/gendocs) a partir de configs/profiles — não edite à mão -->
# Fase 02 — Firewall UFW (4.1.x)

Perfil [`ubuntu_22.04_fase02_firewall_ufw`](../../../configs/profiles/ubuntu_22.04_fase02_firewall_ufw.yaml) · 7 controles.

```bash
make audit_fase02_ufw                     # audita o perfil e gera o HTML em results/
make audit_id ID=4.1.1           # audita um controle
sudo make fix_id ID=4.1.1        # aplica a remediação de um controle
```

> `auditoria/` só lê o sistema. `remediacao/` **altera** o sistema: leia o script e teste numa VM antes de usar em produção.

| ID | Controle | Categoria | Server | Workstation | Auditoria | Remediação |
|---|---|---|:-:|:-:|:-:|:-:|
| 4.1.1 | Ensure ufw is installed | Host Based Firewall - UFW | L1 | L1 | [audit](auditoria/4.1.1_ensure_ufw_is_installed_audit.sh) | [fix](remediacao/4.1.1_ensure_ufw_is_installed_fix.sh) |
| 4.1.2 | Ensure iptables-persistent is not installed with ufw | Host Based Firewall - UFW | L1 | L1 | [audit](auditoria/4.1.2_ensure_iptables_persistent_is_not_installed_with_ufw_audit.sh) | [fix](remediacao/4.1.2_ensure_iptables_persistent_is_not_installed_with_ufw_fix.sh) |
| 4.1.3 | Ensure ufw service is enabled | Host Based Firewall - UFW | L1 | L1 | [audit](auditoria/4.1.3_ensure_ufw_service_is_enabled_audit.sh) | [fix](remediacao/4.1.3_ensure_ufw_service_is_enabled_fix.sh) |
| 4.1.4 | Ensure ufw loopback traffic is configured | Host Based Firewall - UFW | L1 | L1 | [audit](auditoria/4.1.4_ensure_ufw_loopback_traffic_is_configured_audit.sh) | [fix](remediacao/4.1.4_ensure_ufw_loopback_traffic_is_configured_fix.sh) |
| 4.1.5 | Ensure ufw outbound connections are configured | Host Based Firewall - UFW | L1 | L1 | [audit](auditoria/4.1.5_ensure_ufw_outbound_connections_are_configured_audit.sh) | [fix](remediacao/4.1.5_ensure_ufw_outbound_connections_are_configured_fix.sh) |
| 4.1.6 | Ensure ufw firewall rules exist for all open ports | Host Based Firewall - UFW | L1 | L1 | [audit](auditoria/4.1.6_ensure_ufw_firewall_rules_exist_for_all_open_ports_audit.sh) | [fix](remediacao/4.1.6_ensure_ufw_firewall_rules_exist_for_all_open_ports_fix.sh) |
| 4.1.7 | Ensure ufw default deny firewall policy | Host Based Firewall - UFW | L1 | L1 | [audit](auditoria/4.1.7_ensure_ufw_default_deny_firewall_policy_audit.sh) | [fix](remediacao/4.1.7_ensure_ufw_default_deny_firewall_policy_fix.sh) |
