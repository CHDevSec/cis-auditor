#!/bin/bash
# Auditoria: Verifica se solicitações ICMP broadcast são ignoradas

echo "Verificando ignorância de ICMP broadcast..."

value=$(sysctl net.ipv4.icmp_echo_ignore_broadcasts | awk '{print $3}')
[ "$value" -eq 1 ] && echo "✔ Broadcasts ICMP ignorados" || echo "✘ Broadcasts ICMP não ignorados"
