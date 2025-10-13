#!/bin/bash
# Remediação: Remove ou desativa o(s) serviço(s) slapd.service

echo "Parando o(s) serviço(s) slapd.service..."
systemctl stop slapd.service

echo "Tentando remover o pacote slapd..."
if apt purge -y slapd; then
  echo "✅ slapd removido com sucesso"
else
  echo "ℹ️ slapd não pode ser removido, mascarando o(s) serviço(s)..."
  systemctl mask slapd.service
fi
