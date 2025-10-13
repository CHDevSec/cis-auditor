#!/bin/bash
# Auditoria: Verifica se o IP forwarding está desabilitado (IPv4 e IPv6)

echo "Verificando IP forwarding..."

ipv4=$(sysctl net.ipv4.ip_forward | awk '{print $3}')
ipv6=$(sysctl net.ipv6.conf.all.forwarding | awk '{print $3}')

[ "$ipv4" -eq 0 ] && echo "✔ IPv4 forwarding desabilitado" || echo "✘ IPv4 forwarding habilitado"
[ "$ipv6" -eq 0 ] && echo "✔ IPv6 forwarding desabilitado" || echo "✘ IPv6 forwarding habilitado"
