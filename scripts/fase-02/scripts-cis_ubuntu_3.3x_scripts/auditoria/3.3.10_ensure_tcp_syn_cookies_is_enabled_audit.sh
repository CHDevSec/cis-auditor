#!/bin/bash
# Auditoria: Verifica se TCP SYN Cookies estão habilitados

echo "Verificando TCP SYN cookies..."

value=$(sysctl net.ipv4.tcp_syncookies | awk '{print $3}')
[ "$value" -eq 1 ] && echo "✔ tcp_syncookies habilitado" || echo "✘ tcp_syncookies desabilitado"
