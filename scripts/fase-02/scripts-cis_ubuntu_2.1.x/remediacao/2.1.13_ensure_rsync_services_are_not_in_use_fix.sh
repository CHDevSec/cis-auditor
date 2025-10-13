#!/bin/bash
# Remediação: Remove ou desativa o(s) serviço(s) rsync.service

echo "Parando o(s) serviço(s) rsync.service..."
systemctl stop rsync.service

echo "Tentando remover o pacote rsync..."
if apt purge -y rsync; then
  echo "✅ rsync removido com sucesso"
else
  echo "ℹ️ rsync não pode ser removido, mascarando o(s) serviço(s)..."
  systemctl mask rsync.service
fi
