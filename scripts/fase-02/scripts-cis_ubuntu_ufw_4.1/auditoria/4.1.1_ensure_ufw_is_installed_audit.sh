#!/bin/bash
# Verifica se o UFW está instalado
if dpkg -s ufw &>/dev/null; then
  echo "✔ UFW está instalado."
else
  echo "✖ UFW não está instalado."
fi
