#!/bin/bash
# Auditoria: Verifica se anúncios de roteador IPv6 estão desabilitados

echo "Verificando IPv6 Router Advertisements..."

for param in net.ipv6.conf.all.accept_ra net.ipv6.conf.default.accept_ra; do
    val=$(sysctl $param | awk '{print $3}')
    [ "$val" -eq 0 ] && echo "✔ $param desabilitado" || echo "✘ $param habilitado"
done
