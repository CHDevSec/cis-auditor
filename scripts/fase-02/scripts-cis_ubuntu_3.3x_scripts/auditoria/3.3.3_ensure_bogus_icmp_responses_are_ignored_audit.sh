#!/bin/bash
# Auditoria: Verifica se respostas ICMP falsas são ignoradas

echo "Verificando ignorância de ICMP bogus..."

value=$(sysctl net.ipv4.icmp_ignore_bogus_error_responses | awk '{print $3}')
[ "$value" -eq 1 ] && echo "✔ ICMP bogus ignoradas" || echo "✘ ICMP bogus não ignoradas"
