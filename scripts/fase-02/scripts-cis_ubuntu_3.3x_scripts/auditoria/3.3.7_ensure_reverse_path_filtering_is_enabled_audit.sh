#!/bin/bash
# Auditoria: Verifica se Reverse Path Filtering está habilitado

echo "Verificando reverse path filtering..."

for param in net.ipv4.conf.all.rp_filter net.ipv4.conf.default.rp_filter; do
    val=$(sysctl $param | awk '{print $3}')
    [ "$val" -eq 1 ] && echo "✔ $param habilitado" || echo "✘ $param desabilitado"
done
