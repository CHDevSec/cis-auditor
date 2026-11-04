<!-- gerado por `make docs` (tools/gendocs) a partir de configs/profiles — não edite à mão -->
# Controles CIS cobertos

**52 controles** do CIS Ubuntu Linux 22.04 LTS Benchmark em **5 perfis**. Todo controle tem um script de auditoria (só leitura) e um de remediação.

| Perfil | Controles | Comando |
|---|---:|---|
| [Fase 01 — Bootloader, memória, SSH e autenticação](#fase-01--bootloader-memória-ssh-e-autenticação) | 8 | `make audit` |
| [Fase 02 — AppArmor (1.3.x)](#fase-02--apparmor-13x) | 4 | `make audit_fase02_apparmor` |
| [Fase 02 — Firewall UFW (4.1.x)](#fase-02--firewall-ufw-41x) | 7 | `make audit_fase02_ufw` |
| [Fase 02 — Parâmetros de rede (3.3.x)](#fase-02--parâmetros-de-rede-33x) | 11 | `make audit_fase02_rede` |
| [Fase 02 — Serviços de servidor (2.1.x)](#fase-02--serviços-de-servidor-21x) | 22 | `make audit_fase02_servicos` |

## Fase 01 — Bootloader, memória, SSH e autenticação

Perfil `ubuntu_22.04_fase01` · scripts em [`scripts/Fase-01`](../scripts/Fase-01)

| ID | Controle | Categoria | Server | Workstation | Auditoria | Remediação |
|---|---|---|:-:|:-:|:-:|:-:|
| 1.4.1 | Ensure a password is set on the bootloader | Bootloader Configuration | L1 | L1 | [audit](../scripts/Fase-01/auditoria/1.4.1_bootloader_audit.sh) | [fix](../scripts/Fase-01/remediacao/1.4.1_bootloader_fix.sh) |
| 1.5.1 | Ensure Address Space Layout Randomization (ASLR) is enabled | Memory Protection | L1 | L1 | [audit](../scripts/Fase-01/auditoria/1.5.1_enabled_audit.sh) | [fix](../scripts/Fase-01/remediacao/1.5.1_enabled_fix.sh) |
| 1.5.3 | Ensure core dumps are restricted | Memory Protection | L1 | L1 | [audit](../scripts/Fase-01/auditoria/1.5.3_restricted_audit.sh) | [fix](../scripts/Fase-01/remediacao/1.5.3_restricted_fix.sh) |
| 5.1.20 | Ensure SSH root login is disabled | SSH Configuration | L1 | L1 | [audit](../scripts/Fase-01/auditoria/5.1.20_disabled_audit.sh) | [fix](../scripts/Fase-01/remediacao/5.1.20_disabled_fix.sh) |
| 5.1.4 | Ensure SSH root authentication is disabled | SSH Configuration | L1 | L1 | [audit](../scripts/Fase-01/auditoria/5.1.4_disabled_audit.sh) | [fix](../scripts/Fase-01/remediacao/5.1.4_disabled_fix.sh) |
| 5.1.19 | Ensure SSH does not allow empty passwords | SSH Configuration | L1 | L1 | [audit](../scripts/Fase-01/auditoria/5.1.19_passwords_audit.sh) | [fix](../scripts/Fase-01/remediacao/5.1.19_passwords_fix.sh) |
| 5.2.7 | Ensure access to the 'su' command is restricted | User Access | L1 | L1 | [audit](../scripts/Fase-01/auditoria/5.2.7_restricted_audit.sh) | [fix](../scripts/Fase-01/remediacao/5.2.7_restricted_fix.sh) |
| 5.4.1.4 | Ensure password hashing algorithm is SHA-512 | Authentication | L1 | L1 | [audit](../scripts/Fase-01/auditoria/5.4.1.4_sha_512_audit.sh) | [fix](../scripts/Fase-01/remediacao/5.4.1.4_sha_512_fix.sh) |

## Fase 02 — AppArmor (1.3.x)

Perfil `ubuntu_22.04_fase02_apparmor` · scripts em [`scripts/fase-02/scripts-cis_apparmor_fase02`](../scripts/fase-02/scripts-cis_apparmor_fase02)

| ID | Controle | Categoria | Server | Workstation | Auditoria | Remediação |
|---|---|---|:-:|:-:|:-:|:-:|
| 1.3.1 | Ensure AppArmor is installed | AppArmor Configuration | L1 | L1 | [audit](../scripts/fase-02/scripts-cis_apparmor_fase02/auditoria/1.3.1_ensure_apparmor_is_installed_audit.sh) | [fix](../scripts/fase-02/scripts-cis_apparmor_fase02/remediacao/1.3.1_ensure_apparmor_is_installed_fix.sh) |
| 1.3.2 | Ensure AppArmor is enabled in the bootloader | AppArmor Configuration | L1 | L1 | [audit](../scripts/fase-02/scripts-cis_apparmor_fase02/auditoria/1.3.2_ensure_apparmor_is_enabled_in_the_bootloader_audit.sh) | [fix](../scripts/fase-02/scripts-cis_apparmor_fase02/remediacao/1.3.2_ensure_apparmor_is_enabled_in_the_bootloader_fix.sh) |
| 1.3.3 | Ensure all AppArmor profiles are in enforce or complain mode | AppArmor Configuration | L1 | L1 | [audit](../scripts/fase-02/scripts-cis_apparmor_fase02/auditoria/1.3.3_ensure_all_apparmor_profiles_are_in_enforce_or_complain_mode_audit.sh) | [fix](../scripts/fase-02/scripts-cis_apparmor_fase02/remediacao/1.3.3_ensure_all_apparmor_profiles_are_in_enforce_or_complain_mode_fix.sh) |
| 1.3.4 | Ensure all AppArmor profiles are enforced | AppArmor Configuration | L1 | L1 | [audit](../scripts/fase-02/scripts-cis_apparmor_fase02/auditoria/1.3.4_ensure_all_apparmor_profiles_are_enforced_audit.sh) | [fix](../scripts/fase-02/scripts-cis_apparmor_fase02/remediacao/1.3.4_ensure_all_apparmor_profiles_are_enforced_fix.sh) |

## Fase 02 — Firewall UFW (4.1.x)

Perfil `ubuntu_22.04_fase02_firewall_ufw` · scripts em [`scripts/fase-02/scripts-cis_ubuntu_ufw_4.1`](../scripts/fase-02/scripts-cis_ubuntu_ufw_4.1)

| ID | Controle | Categoria | Server | Workstation | Auditoria | Remediação |
|---|---|---|:-:|:-:|:-:|:-:|
| 4.1.1 | Ensure ufw is installed | Host Based Firewall - UFW | L1 | L1 | [audit](../scripts/fase-02/scripts-cis_ubuntu_ufw_4.1/auditoria/4.1.1_ensure_ufw_is_installed_audit.sh) | [fix](../scripts/fase-02/scripts-cis_ubuntu_ufw_4.1/remediacao/4.1.1_ensure_ufw_is_installed_fix.sh) |
| 4.1.2 | Ensure iptables-persistent is not installed with ufw | Host Based Firewall - UFW | L1 | L1 | [audit](../scripts/fase-02/scripts-cis_ubuntu_ufw_4.1/auditoria/4.1.2_ensure_iptables_persistent_is_not_installed_with_ufw_audit.sh) | [fix](../scripts/fase-02/scripts-cis_ubuntu_ufw_4.1/remediacao/4.1.2_ensure_iptables_persistent_is_not_installed_with_ufw_fix.sh) |
| 4.1.3 | Ensure ufw service is enabled | Host Based Firewall - UFW | L1 | L1 | [audit](../scripts/fase-02/scripts-cis_ubuntu_ufw_4.1/auditoria/4.1.3_ensure_ufw_service_is_enabled_audit.sh) | [fix](../scripts/fase-02/scripts-cis_ubuntu_ufw_4.1/remediacao/4.1.3_ensure_ufw_service_is_enabled_fix.sh) |
| 4.1.4 | Ensure ufw loopback traffic is configured | Host Based Firewall - UFW | L1 | L1 | [audit](../scripts/fase-02/scripts-cis_ubuntu_ufw_4.1/auditoria/4.1.4_ensure_ufw_loopback_traffic_is_configured_audit.sh) | [fix](../scripts/fase-02/scripts-cis_ubuntu_ufw_4.1/remediacao/4.1.4_ensure_ufw_loopback_traffic_is_configured_fix.sh) |
| 4.1.5 | Ensure ufw outbound connections are configured | Host Based Firewall - UFW | L1 | L1 | [audit](../scripts/fase-02/scripts-cis_ubuntu_ufw_4.1/auditoria/4.1.5_ensure_ufw_outbound_connections_are_configured_audit.sh) | [fix](../scripts/fase-02/scripts-cis_ubuntu_ufw_4.1/remediacao/4.1.5_ensure_ufw_outbound_connections_are_configured_fix.sh) |
| 4.1.6 | Ensure ufw firewall rules exist for all open ports | Host Based Firewall - UFW | L1 | L1 | [audit](../scripts/fase-02/scripts-cis_ubuntu_ufw_4.1/auditoria/4.1.6_ensure_ufw_firewall_rules_exist_for_all_open_ports_audit.sh) | [fix](../scripts/fase-02/scripts-cis_ubuntu_ufw_4.1/remediacao/4.1.6_ensure_ufw_firewall_rules_exist_for_all_open_ports_fix.sh) |
| 4.1.7 | Ensure ufw default deny firewall policy | Host Based Firewall - UFW | L1 | L1 | [audit](../scripts/fase-02/scripts-cis_ubuntu_ufw_4.1/auditoria/4.1.7_ensure_ufw_default_deny_firewall_policy_audit.sh) | [fix](../scripts/fase-02/scripts-cis_ubuntu_ufw_4.1/remediacao/4.1.7_ensure_ufw_default_deny_firewall_policy_fix.sh) |

## Fase 02 — Parâmetros de rede (3.3.x)

Perfil `ubuntu_22.04_fase02_rede` · scripts em [`scripts/fase-02/scripts-cis_ubuntu_3.3x_scripts`](../scripts/fase-02/scripts-cis_ubuntu_3.3x_scripts)

| ID | Controle | Categoria | Server | Workstation | Auditoria | Remediação |
|---|---|---|:-:|:-:|:-:|:-:|
| 3.3.1 | Ensure ip forwarding is disabled | Network Parameters Hardening | L1 | L1 | [audit](../scripts/fase-02/scripts-cis_ubuntu_3.3x_scripts/auditoria/3.3.1_ensure_ip_forwarding_is_disabled_audit.sh) | [fix](../scripts/fase-02/scripts-cis_ubuntu_3.3x_scripts/remediacao/3.3.1_ensure_ip_forwarding_is_disabled_fix.sh) |
| 3.3.2 | Ensure packet redirect sending is disabled | Network Parameters Hardening | L1 | L1 | [audit](../scripts/fase-02/scripts-cis_ubuntu_3.3x_scripts/auditoria/3.3.2_ensure_packet_redirect_sending_is_disabled_audit.sh) | [fix](../scripts/fase-02/scripts-cis_ubuntu_3.3x_scripts/remediacao/3.3.2_ensure_packet_redirect_sending_is_disabled_fix.sh) |
| 3.3.3 | Ensure bogus icmp responses are ignored | Network Parameters Hardening | L1 | L1 | [audit](../scripts/fase-02/scripts-cis_ubuntu_3.3x_scripts/auditoria/3.3.3_ensure_bogus_icmp_responses_are_ignored_audit.sh) | [fix](../scripts/fase-02/scripts-cis_ubuntu_3.3x_scripts/remediacao/3.3.3_ensure_bogus_icmp_responses_are_ignored_fix.sh) |
| 3.3.4 | Ensure broadcast icmp requests are ignored | Network Parameters Hardening | L1 | L1 | [audit](../scripts/fase-02/scripts-cis_ubuntu_3.3x_scripts/auditoria/3.3.4_ensure_broadcast_icmp_requests_are_ignored_audit.sh) | [fix](../scripts/fase-02/scripts-cis_ubuntu_3.3x_scripts/remediacao/3.3.4_ensure_broadcast_icmp_requests_are_ignored_fix.sh) |
| 3.3.5 | Ensure icmp redirects are not accepted | Network Parameters Hardening | L1 | L1 | [audit](../scripts/fase-02/scripts-cis_ubuntu_3.3x_scripts/auditoria/3.3.5_ensure_icmp_redirects_are_not_accepted_audit.sh) | [fix](../scripts/fase-02/scripts-cis_ubuntu_3.3x_scripts/remediacao/3.3.5_ensure_icmp_redirects_are_not_accepted_fix.sh) |
| 3.3.6 | Ensure secure icmp redirects are not accepted | Network Parameters Hardening | L1 | L1 | [audit](../scripts/fase-02/scripts-cis_ubuntu_3.3x_scripts/auditoria/3.3.6_ensure_secure_icmp_redirects_are_not_accepted_audit.sh) | [fix](../scripts/fase-02/scripts-cis_ubuntu_3.3x_scripts/remediacao/3.3.6_ensure_secure_icmp_redirects_are_not_accepted_fix.sh) |
| 3.3.7 | Ensure reverse path filtering is enabled | Network Parameters Hardening | L1 | L1 | [audit](../scripts/fase-02/scripts-cis_ubuntu_3.3x_scripts/auditoria/3.3.7_ensure_reverse_path_filtering_is_enabled_audit.sh) | [fix](../scripts/fase-02/scripts-cis_ubuntu_3.3x_scripts/remediacao/3.3.7_ensure_reverse_path_filtering_is_enabled_fix.sh) |
| 3.3.8 | Ensure source routed packets are not accepted | Network Parameters Hardening | L1 | L1 | [audit](../scripts/fase-02/scripts-cis_ubuntu_3.3x_scripts/auditoria/3.3.8_ensure_source_routed_packets_are_not_accepted_audit.sh) | [fix](../scripts/fase-02/scripts-cis_ubuntu_3.3x_scripts/remediacao/3.3.8_ensure_source_routed_packets_are_not_accepted_fix.sh) |
| 3.3.9 | Ensure suspicious packets are logged | Network Parameters Hardening | L1 | L1 | [audit](../scripts/fase-02/scripts-cis_ubuntu_3.3x_scripts/auditoria/3.3.9_ensure_suspicious_packets_are_logged_audit.sh) | [fix](../scripts/fase-02/scripts-cis_ubuntu_3.3x_scripts/remediacao/3.3.9_ensure_suspicious_packets_are_logged_fix.sh) |
| 3.3.10 | Ensure tcp syn cookies is enabled | Network Parameters Hardening | L1 | L1 | [audit](../scripts/fase-02/scripts-cis_ubuntu_3.3x_scripts/auditoria/3.3.10_ensure_tcp_syn_cookies_is_enabled_audit.sh) | [fix](../scripts/fase-02/scripts-cis_ubuntu_3.3x_scripts/remediacao/3.3.10_ensure_tcp_syn_cookies_is_enabled_fix.sh) |
| 3.3.11 | Ensure ipv6 router advertisements are not accepted | Network Parameters Hardening | L1 | L1 | [audit](../scripts/fase-02/scripts-cis_ubuntu_3.3x_scripts/auditoria/3.3.11_ensure_ipv6_router_advertisements_are_not_accepted_audit.sh) | [fix](../scripts/fase-02/scripts-cis_ubuntu_3.3x_scripts/remediacao/3.3.11_ensure_ipv6_router_advertisements_are_not_accepted_fix.sh) |

## Fase 02 — Serviços de servidor (2.1.x)

Perfil `ubuntu_22.04_fase02_servicos` · scripts em [`scripts/fase-02/scripts-cis_ubuntu_2.1.x`](../scripts/fase-02/scripts-cis_ubuntu_2.1.x)

| ID | Controle | Categoria | Server | Workstation | Auditoria | Remediação |
|---|---|---|:-:|:-:|:-:|:-:|
| 2.1.1 | Ensure autofs services are not in use | Server Services Configuration | L1 | L1 | [audit](../scripts/fase-02/scripts-cis_ubuntu_2.1.x/auditoria/2.1.1_ensure_autofs_services_are_not_in_use_audit.sh) | [fix](../scripts/fase-02/scripts-cis_ubuntu_2.1.x/remediacao/2.1.1_ensure_autofs_services_are_not_in_use_fix.sh) |
| 2.1.2 | Ensure avahi daemon services are not in use | Server Services Configuration | L1 | L1 | [audit](../scripts/fase-02/scripts-cis_ubuntu_2.1.x/auditoria/2.1.2_ensure_avahi_daemon_services_are_not_in_use_audit.sh) | [fix](../scripts/fase-02/scripts-cis_ubuntu_2.1.x/remediacao/2.1.2_ensure_avahi_daemon_services_are_not_in_use_fix.sh) |
| 2.1.3 | Ensure dhcp server services are not in use | Server Services Configuration | L1 | L1 | [audit](../scripts/fase-02/scripts-cis_ubuntu_2.1.x/auditoria/2.1.3_ensure_dhcp_server_services_are_not_in_use_audit.sh) | [fix](../scripts/fase-02/scripts-cis_ubuntu_2.1.x/remediacao/2.1.3_ensure_dhcp_server_services_are_not_in_use_fix.sh) |
| 2.1.4 | Ensure dns server services are not in use | Server Services Configuration | L1 | L1 | [audit](../scripts/fase-02/scripts-cis_ubuntu_2.1.x/auditoria/2.1.4_ensure_dns_server_services_are_not_in_use_audit.sh) | [fix](../scripts/fase-02/scripts-cis_ubuntu_2.1.x/remediacao/2.1.4_ensure_dns_server_services_are_not_in_use_fix.sh) |
| 2.1.5 | Ensure dnsmasq services are not in use | Server Services Configuration | L1 | L1 | [audit](../scripts/fase-02/scripts-cis_ubuntu_2.1.x/auditoria/2.1.5_ensure_dnsmasq_services_are_not_in_use_audit.sh) | [fix](../scripts/fase-02/scripts-cis_ubuntu_2.1.x/remediacao/2.1.5_ensure_dnsmasq_services_are_not_in_use_fix.sh) |
| 2.1.6 | Ensure ftp server services are not in use | Server Services Configuration | L1 | L1 | [audit](../scripts/fase-02/scripts-cis_ubuntu_2.1.x/auditoria/2.1.6_ensure_ftp_server_services_are_not_in_use_audit.sh) | [fix](../scripts/fase-02/scripts-cis_ubuntu_2.1.x/remediacao/2.1.6_ensure_ftp_server_services_are_not_in_use_fix.sh) |
| 2.1.7 | Ensure ldap server services are not in use | Server Services Configuration | L1 | L1 | [audit](../scripts/fase-02/scripts-cis_ubuntu_2.1.x/auditoria/2.1.7_ensure_ldap_server_services_are_not_in_use_audit.sh) | [fix](../scripts/fase-02/scripts-cis_ubuntu_2.1.x/remediacao/2.1.7_ensure_ldap_server_services_are_not_in_use_fix.sh) |
| 2.1.8 | Ensure message access server services are not in use | Server Services Configuration | L1 | L1 | [audit](../scripts/fase-02/scripts-cis_ubuntu_2.1.x/auditoria/2.1.8_ensure_message_access_server_services_are_not_in_use_audit.sh) | [fix](../scripts/fase-02/scripts-cis_ubuntu_2.1.x/remediacao/2.1.8_ensure_message_access_server_services_are_not_in_use_fix.sh) |
| 2.1.9 | Ensure network file system services are not in use | Server Services Configuration | L1 | L1 | [audit](../scripts/fase-02/scripts-cis_ubuntu_2.1.x/auditoria/2.1.9_ensure_network_file_system_services_are_not_in_use_audit.sh) | [fix](../scripts/fase-02/scripts-cis_ubuntu_2.1.x/remediacao/2.1.9_ensure_network_file_system_services_are_not_in_use_fix.sh) |
| 2.1.10 | Ensure nis server services are not in use | Server Services Configuration | L1 | L1 | [audit](../scripts/fase-02/scripts-cis_ubuntu_2.1.x/auditoria/2.1.10_ensure_nis_server_services_are_not_in_use_audit.sh) | [fix](../scripts/fase-02/scripts-cis_ubuntu_2.1.x/remediacao/2.1.10_ensure_nis_server_services_are_not_in_use_fix.sh) |
| 2.1.11 | Ensure print server services are not in use | Server Services Configuration | L1 | L1 | [audit](../scripts/fase-02/scripts-cis_ubuntu_2.1.x/auditoria/2.1.11_ensure_print_server_services_are_not_in_use_audit.sh) | [fix](../scripts/fase-02/scripts-cis_ubuntu_2.1.x/remediacao/2.1.11_ensure_print_server_services_are_not_in_use_fix.sh) |
| 2.1.12 | Ensure rpcbind services are not in use | Server Services Configuration | L1 | L1 | [audit](../scripts/fase-02/scripts-cis_ubuntu_2.1.x/auditoria/2.1.12_ensure_rpcbind_services_are_not_in_use_audit.sh) | [fix](../scripts/fase-02/scripts-cis_ubuntu_2.1.x/remediacao/2.1.12_ensure_rpcbind_services_are_not_in_use_fix.sh) |
| 2.1.13 | Ensure rsync services are not in use | Server Services Configuration | L1 | L1 | [audit](../scripts/fase-02/scripts-cis_ubuntu_2.1.x/auditoria/2.1.13_ensure_rsync_services_are_not_in_use_audit.sh) | [fix](../scripts/fase-02/scripts-cis_ubuntu_2.1.x/remediacao/2.1.13_ensure_rsync_services_are_not_in_use_fix.sh) |
| 2.1.14 | Ensure samba file server services are not in use | Server Services Configuration | L1 | L1 | [audit](../scripts/fase-02/scripts-cis_ubuntu_2.1.x/auditoria/2.1.14_ensure_samba_file_server_services_are_not_in_use_audit.sh) | [fix](../scripts/fase-02/scripts-cis_ubuntu_2.1.x/remediacao/2.1.14_ensure_samba_file_server_services_are_not_in_use_fix.sh) |
| 2.1.15 | Ensure snmp services are not in use | Server Services Configuration | L1 | L1 | [audit](../scripts/fase-02/scripts-cis_ubuntu_2.1.x/auditoria/2.1.15_ensure_snmp_services_are_not_in_use_audit.sh) | [fix](../scripts/fase-02/scripts-cis_ubuntu_2.1.x/remediacao/2.1.15_ensure_snmp_services_are_not_in_use_fix.sh) |
| 2.1.16 | Ensure tftp server services are not in use | Server Services Configuration | L1 | L1 | [audit](../scripts/fase-02/scripts-cis_ubuntu_2.1.x/auditoria/2.1.16_ensure_tftp_server_services_are_not_in_use_audit.sh) | [fix](../scripts/fase-02/scripts-cis_ubuntu_2.1.x/remediacao/2.1.16_ensure_tftp_server_services_are_not_in_use_fix.sh) |
| 2.1.17 | Ensure web proxy server services are not in use | Server Services Configuration | L1 | L1 | [audit](../scripts/fase-02/scripts-cis_ubuntu_2.1.x/auditoria/2.1.17_ensure_web_proxy_server_services_are_not_in_use_audit.sh) | [fix](../scripts/fase-02/scripts-cis_ubuntu_2.1.x/remediacao/2.1.17_ensure_web_proxy_server_services_are_not_in_use_fix.sh) |
| 2.1.18 | Ensure web server services are not in use | Server Services Configuration | L1 | L1 | [audit](../scripts/fase-02/scripts-cis_ubuntu_2.1.x/auditoria/2.1.18_ensure_web_server_services_are_not_in_use_audit.sh) | [fix](../scripts/fase-02/scripts-cis_ubuntu_2.1.x/remediacao/2.1.18_ensure_web_server_services_are_not_in_use_fix.sh) |
| 2.1.19 | Ensure xinetd services are not in use | Server Services Configuration | L1 | L1 | [audit](../scripts/fase-02/scripts-cis_ubuntu_2.1.x/auditoria/2.1.19_ensure_xinetd_services_are_not_in_use_audit.sh) | [fix](../scripts/fase-02/scripts-cis_ubuntu_2.1.x/remediacao/2.1.19_ensure_xinetd_services_are_not_in_use_fix.sh) |
| 2.1.20 | Ensure X window server services are not in use | Server Services Configuration | L1 | L1 | [audit](../scripts/fase-02/scripts-cis_ubuntu_2.1.x/auditoria/2.1.20_ensure_x_window_server_services_are_not_in_use_audit.sh) | [fix](../scripts/fase-02/scripts-cis_ubuntu_2.1.x/remediacao/2.1.20_ensure_x_window_server_services_are_not_in_use_fix.sh) |
| 2.1.21 | Ensure mail transfer agent is configured for local-only mode | Server Services Configuration | L1 | L1 | [audit](../scripts/fase-02/scripts-cis_ubuntu_2.1.x/auditoria/2.1.21_ensure_mail_transfer_agent_is_configured_for_local_only_mode_audit.sh) | [fix](../scripts/fase-02/scripts-cis_ubuntu_2.1.x/remediacao/2.1.21_ensure_mail_transfer_agent_is_configured_for_local_only_mode_fix.sh) |
| 2.1.22 | Ensure only approved services are listening on a network interface | Server Services Configuration | L1 | L1 | [audit](../scripts/fase-02/scripts-cis_ubuntu_2.1.x/auditoria/2.1.22_ensure_only_approved_services_are_listening_on_a_network_interface_audit.sh) | [fix](../scripts/fase-02/scripts-cis_ubuntu_2.1.x/remediacao/2.1.22_ensure_only_approved_services_are_listening_on_a_network_interface_fix.sh) |
