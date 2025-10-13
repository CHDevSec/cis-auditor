#!/bin/bash
# Remediação: Remove ou desativa o(s) serviço(s) nfs-server.service

echo "Parando o(s) serviço(s) nfs-server.service..."
systemctl stop nfs-server.service

echo "Tentando remover o pacote nfs-kernel-server..."
if apt purge -y nfs-kernel-server; then
  echo "✅ nfs-kernel-server removido com sucesso"
else
  echo "ℹ️ nfs-kernel-server não pode ser removido, mascarando o(s) serviço(s)..."
  systemctl mask nfs-server.service
fi
