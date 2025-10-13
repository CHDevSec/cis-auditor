#!/bin/bash
# Auditoria: Verifica se pacotes suspeitos estão sendo logados

echo "Verificando log de pacotes suspeitos..."

value=$(sysctl net.ipv4.conf.all.log_martians | awk '{print $3}')
[ "$value" -eq 1 ] && echo "✔ log_martians habilitado" || echo "✘ log_martians desabilitado"
