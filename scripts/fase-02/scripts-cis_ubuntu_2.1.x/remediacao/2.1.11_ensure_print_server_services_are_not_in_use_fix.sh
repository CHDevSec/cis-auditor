#!/bin/bash
# Remediação: Remove ou desativa o(s) serviço(s) cups.socket cups.service

echo "Parando o(s) serviço(s) cups.socket cups.service..."
systemctl stop cups.socket cups.service

echo "Tentando remover o pacote cups..."
if apt purge -y cups; then
  echo "✅ cups removido com sucesso"
else
  echo "ℹ️ cups não pode ser removido, mascarando o(s) serviço(s)..."
  systemctl mask cups.socket cups.service
fi
