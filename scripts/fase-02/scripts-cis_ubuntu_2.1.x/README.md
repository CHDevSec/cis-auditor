<!-- gerado por `make docs` (tools/gendocs) a partir de configs/profiles — não edite à mão -->
# Fase 02 — Serviços de servidor (2.1.x)

Perfil [`ubuntu_22.04_fase02_servicos`](../../../configs/profiles/ubuntu_22.04_fase02_servicos.yaml) · 22 controles.

```bash
make audit_fase02_servicos                     # audita o perfil e gera o HTML em results/
make audit_id ID=2.1.1           # audita um controle
sudo make fix_id ID=2.1.1        # aplica a remediação de um controle
```

> `auditoria/` só lê o sistema. `remediacao/` **altera** o sistema: leia o script e teste numa VM antes de usar em produção.

| ID | Controle | Categoria | Server | Workstation | Auditoria | Remediação |
|---|---|---|:-:|:-:|:-:|:-:|
| 2.1.1 | Ensure autofs services are not in use | Server Services Configuration | L1 | L1 | [audit](auditoria/2.1.1_ensure_autofs_services_are_not_in_use_audit.sh) | [fix](remediacao/2.1.1_ensure_autofs_services_are_not_in_use_fix.sh) |
| 2.1.2 | Ensure avahi daemon services are not in use | Server Services Configuration | L1 | L1 | [audit](auditoria/2.1.2_ensure_avahi_daemon_services_are_not_in_use_audit.sh) | [fix](remediacao/2.1.2_ensure_avahi_daemon_services_are_not_in_use_fix.sh) |
| 2.1.3 | Ensure dhcp server services are not in use | Server Services Configuration | L1 | L1 | [audit](auditoria/2.1.3_ensure_dhcp_server_services_are_not_in_use_audit.sh) | [fix](remediacao/2.1.3_ensure_dhcp_server_services_are_not_in_use_fix.sh) |
| 2.1.4 | Ensure dns server services are not in use | Server Services Configuration | L1 | L1 | [audit](auditoria/2.1.4_ensure_dns_server_services_are_not_in_use_audit.sh) | [fix](remediacao/2.1.4_ensure_dns_server_services_are_not_in_use_fix.sh) |
| 2.1.5 | Ensure dnsmasq services are not in use | Server Services Configuration | L1 | L1 | [audit](auditoria/2.1.5_ensure_dnsmasq_services_are_not_in_use_audit.sh) | [fix](remediacao/2.1.5_ensure_dnsmasq_services_are_not_in_use_fix.sh) |
| 2.1.6 | Ensure ftp server services are not in use | Server Services Configuration | L1 | L1 | [audit](auditoria/2.1.6_ensure_ftp_server_services_are_not_in_use_audit.sh) | [fix](remediacao/2.1.6_ensure_ftp_server_services_are_not_in_use_fix.sh) |
| 2.1.7 | Ensure ldap server services are not in use | Server Services Configuration | L1 | L1 | [audit](auditoria/2.1.7_ensure_ldap_server_services_are_not_in_use_audit.sh) | [fix](remediacao/2.1.7_ensure_ldap_server_services_are_not_in_use_fix.sh) |
| 2.1.8 | Ensure message access server services are not in use | Server Services Configuration | L1 | L1 | [audit](auditoria/2.1.8_ensure_message_access_server_services_are_not_in_use_audit.sh) | [fix](remediacao/2.1.8_ensure_message_access_server_services_are_not_in_use_fix.sh) |
| 2.1.9 | Ensure network file system services are not in use | Server Services Configuration | L1 | L1 | [audit](auditoria/2.1.9_ensure_network_file_system_services_are_not_in_use_audit.sh) | [fix](remediacao/2.1.9_ensure_network_file_system_services_are_not_in_use_fix.sh) |
| 2.1.10 | Ensure nis server services are not in use | Server Services Configuration | L1 | L1 | [audit](auditoria/2.1.10_ensure_nis_server_services_are_not_in_use_audit.sh) | [fix](remediacao/2.1.10_ensure_nis_server_services_are_not_in_use_fix.sh) |
| 2.1.11 | Ensure print server services are not in use | Server Services Configuration | L1 | L1 | [audit](auditoria/2.1.11_ensure_print_server_services_are_not_in_use_audit.sh) | [fix](remediacao/2.1.11_ensure_print_server_services_are_not_in_use_fix.sh) |
| 2.1.12 | Ensure rpcbind services are not in use | Server Services Configuration | L1 | L1 | [audit](auditoria/2.1.12_ensure_rpcbind_services_are_not_in_use_audit.sh) | [fix](remediacao/2.1.12_ensure_rpcbind_services_are_not_in_use_fix.sh) |
| 2.1.13 | Ensure rsync services are not in use | Server Services Configuration | L1 | L1 | [audit](auditoria/2.1.13_ensure_rsync_services_are_not_in_use_audit.sh) | [fix](remediacao/2.1.13_ensure_rsync_services_are_not_in_use_fix.sh) |
| 2.1.14 | Ensure samba file server services are not in use | Server Services Configuration | L1 | L1 | [audit](auditoria/2.1.14_ensure_samba_file_server_services_are_not_in_use_audit.sh) | [fix](remediacao/2.1.14_ensure_samba_file_server_services_are_not_in_use_fix.sh) |
| 2.1.15 | Ensure snmp services are not in use | Server Services Configuration | L1 | L1 | [audit](auditoria/2.1.15_ensure_snmp_services_are_not_in_use_audit.sh) | [fix](remediacao/2.1.15_ensure_snmp_services_are_not_in_use_fix.sh) |
| 2.1.16 | Ensure tftp server services are not in use | Server Services Configuration | L1 | L1 | [audit](auditoria/2.1.16_ensure_tftp_server_services_are_not_in_use_audit.sh) | [fix](remediacao/2.1.16_ensure_tftp_server_services_are_not_in_use_fix.sh) |
| 2.1.17 | Ensure web proxy server services are not in use | Server Services Configuration | L1 | L1 | [audit](auditoria/2.1.17_ensure_web_proxy_server_services_are_not_in_use_audit.sh) | [fix](remediacao/2.1.17_ensure_web_proxy_server_services_are_not_in_use_fix.sh) |
| 2.1.18 | Ensure web server services are not in use | Server Services Configuration | L1 | L1 | [audit](auditoria/2.1.18_ensure_web_server_services_are_not_in_use_audit.sh) | [fix](remediacao/2.1.18_ensure_web_server_services_are_not_in_use_fix.sh) |
| 2.1.19 | Ensure xinetd services are not in use | Server Services Configuration | L1 | L1 | [audit](auditoria/2.1.19_ensure_xinetd_services_are_not_in_use_audit.sh) | [fix](remediacao/2.1.19_ensure_xinetd_services_are_not_in_use_fix.sh) |
| 2.1.20 | Ensure X window server services are not in use | Server Services Configuration | L1 | L1 | [audit](auditoria/2.1.20_ensure_x_window_server_services_are_not_in_use_audit.sh) | [fix](remediacao/2.1.20_ensure_x_window_server_services_are_not_in_use_fix.sh) |
| 2.1.21 | Ensure mail transfer agent is configured for local-only mode | Server Services Configuration | L1 | L1 | [audit](auditoria/2.1.21_ensure_mail_transfer_agent_is_configured_for_local_only_mode_audit.sh) | [fix](remediacao/2.1.21_ensure_mail_transfer_agent_is_configured_for_local_only_mode_fix.sh) |
| 2.1.22 | Ensure only approved services are listening on a network interface | Server Services Configuration | L1 | L1 | [audit](auditoria/2.1.22_ensure_only_approved_services_are_listening_on_a_network_interface_audit.sh) | [fix](remediacao/2.1.22_ensure_only_approved_services_are_listening_on_a_network_interface_fix.sh) |
