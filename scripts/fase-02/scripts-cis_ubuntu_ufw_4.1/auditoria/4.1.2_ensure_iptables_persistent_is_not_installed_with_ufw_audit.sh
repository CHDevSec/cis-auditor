#!/bin/bash
# Verifica se o pacote iptables-persistent está instalado
if dpkg -s iptables-persistent &>/dev/null; then
  echo "✖ iptables-persistent está instalado com UFW."
else
  echo "✔ iptables-persistent não está instalado com UFW."
fi
