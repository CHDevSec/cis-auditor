#!/bin/bash
# Verifica se o serviço do UFW está ativo
if systemctl is-enabled ufw &>/dev/null; then
  echo "✔ Serviço UFW está habilitado."
else
  echo "✖ Serviço UFW não está habilitado."
fi
