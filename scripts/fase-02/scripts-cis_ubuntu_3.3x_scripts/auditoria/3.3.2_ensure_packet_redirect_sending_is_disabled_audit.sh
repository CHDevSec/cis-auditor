#!/bin/bash
# Auditoria: Verifica se envio de redirects está desabilitado

echo "Verificando envio de ICMP redirects..."

all=$(sysctl net.ipv4.conf.all.send_redirects | awk '{print $3}')
default=$(sysctl net.ipv4.conf.default.send_redirects | awk '{print $3}')

[ "$all" -eq 0 ] && echo "✔ all.send_redirects desabilitado" || echo "✘ all.send_redirects habilitado"
[ "$default" -eq 0 ] && echo "✔ default.send_redirects desabilitado" || echo "✘ default.send_redirects habilitado"
