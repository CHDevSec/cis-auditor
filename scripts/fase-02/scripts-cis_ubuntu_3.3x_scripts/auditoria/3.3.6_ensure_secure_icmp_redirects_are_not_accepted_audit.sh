#!/bin/bash
# Auditoria: Verifica se ICMP redirects seguros estão desabilitados

echo "Verificando secure ICMP redirects..."

for param in net.ipv4.conf.all.secure_redirects net.ipv4.conf.default.secure_redirects; do
    val=$(sysctl $param | awk '{print $3}')
    [ "$val" -eq 0 ] && echo "✔ $param desabilitado" || echo "✘ $param habilitado"
done
