#!/bin/bash
# Auditoria: Verifica se ICMP redirects estão desabilitados

echo "Verificando ICMP redirects..."

for param in net.ipv4.conf.all.accept_redirects net.ipv4.conf.default.accept_redirects net.ipv6.conf.all.accept_redirects net.ipv6.conf.default.accept_redirects; do
    val=$(sysctl $param | awk '{print $3}')
    [ "$val" -eq 0 ] && echo "✔ $param desabilitado" || echo "✘ $param habilitado"
done
