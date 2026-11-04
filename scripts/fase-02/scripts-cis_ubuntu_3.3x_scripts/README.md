<!-- gerado por `make docs` (tools/gendocs) a partir de configs/profiles — não edite à mão -->
# Fase 02 — Parâmetros de rede (3.3.x)

Perfil [`ubuntu_22.04_fase02_rede`](../../../configs/profiles/ubuntu_22.04_fase02_rede.yaml) · 11 controles.

```bash
make audit_fase02_rede                     # audita o perfil e gera o HTML em results/
make audit_id ID=3.3.1           # audita um controle
sudo make fix_id ID=3.3.1        # aplica a remediação de um controle
```

> `auditoria/` só lê o sistema. `remediacao/` **altera** o sistema: leia o script e teste numa VM antes de usar em produção.

| ID | Controle | Categoria | Server | Workstation | Auditoria | Remediação |
|---|---|---|:-:|:-:|:-:|:-:|
| 3.3.1 | Ensure ip forwarding is disabled | Network Parameters Hardening | L1 | L1 | [audit](auditoria/3.3.1_ensure_ip_forwarding_is_disabled_audit.sh) | [fix](remediacao/3.3.1_ensure_ip_forwarding_is_disabled_fix.sh) |
| 3.3.2 | Ensure packet redirect sending is disabled | Network Parameters Hardening | L1 | L1 | [audit](auditoria/3.3.2_ensure_packet_redirect_sending_is_disabled_audit.sh) | [fix](remediacao/3.3.2_ensure_packet_redirect_sending_is_disabled_fix.sh) |
| 3.3.3 | Ensure bogus icmp responses are ignored | Network Parameters Hardening | L1 | L1 | [audit](auditoria/3.3.3_ensure_bogus_icmp_responses_are_ignored_audit.sh) | [fix](remediacao/3.3.3_ensure_bogus_icmp_responses_are_ignored_fix.sh) |
| 3.3.4 | Ensure broadcast icmp requests are ignored | Network Parameters Hardening | L1 | L1 | [audit](auditoria/3.3.4_ensure_broadcast_icmp_requests_are_ignored_audit.sh) | [fix](remediacao/3.3.4_ensure_broadcast_icmp_requests_are_ignored_fix.sh) |
| 3.3.5 | Ensure icmp redirects are not accepted | Network Parameters Hardening | L1 | L1 | [audit](auditoria/3.3.5_ensure_icmp_redirects_are_not_accepted_audit.sh) | [fix](remediacao/3.3.5_ensure_icmp_redirects_are_not_accepted_fix.sh) |
| 3.3.6 | Ensure secure icmp redirects are not accepted | Network Parameters Hardening | L1 | L1 | [audit](auditoria/3.3.6_ensure_secure_icmp_redirects_are_not_accepted_audit.sh) | [fix](remediacao/3.3.6_ensure_secure_icmp_redirects_are_not_accepted_fix.sh) |
| 3.3.7 | Ensure reverse path filtering is enabled | Network Parameters Hardening | L1 | L1 | [audit](auditoria/3.3.7_ensure_reverse_path_filtering_is_enabled_audit.sh) | [fix](remediacao/3.3.7_ensure_reverse_path_filtering_is_enabled_fix.sh) |
| 3.3.8 | Ensure source routed packets are not accepted | Network Parameters Hardening | L1 | L1 | [audit](auditoria/3.3.8_ensure_source_routed_packets_are_not_accepted_audit.sh) | [fix](remediacao/3.3.8_ensure_source_routed_packets_are_not_accepted_fix.sh) |
| 3.3.9 | Ensure suspicious packets are logged | Network Parameters Hardening | L1 | L1 | [audit](auditoria/3.3.9_ensure_suspicious_packets_are_logged_audit.sh) | [fix](remediacao/3.3.9_ensure_suspicious_packets_are_logged_fix.sh) |
| 3.3.10 | Ensure tcp syn cookies is enabled | Network Parameters Hardening | L1 | L1 | [audit](auditoria/3.3.10_ensure_tcp_syn_cookies_is_enabled_audit.sh) | [fix](remediacao/3.3.10_ensure_tcp_syn_cookies_is_enabled_fix.sh) |
| 3.3.11 | Ensure ipv6 router advertisements are not accepted | Network Parameters Hardening | L1 | L1 | [audit](auditoria/3.3.11_ensure_ipv6_router_advertisements_are_not_accepted_audit.sh) | [fix](remediacao/3.3.11_ensure_ipv6_router_advertisements_are_not_accepted_fix.sh) |
