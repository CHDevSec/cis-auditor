#!/bin/bash
# Remediação: Remove ou desativa o(s) serviço(s) rpcbind.socket rpcbind.service

echo "Parando o(s) serviço(s) rpcbind.socket rpcbind.service..."
systemctl stop rpcbind.socket rpcbind.service

echo "Tentando remover o pacote rpcbind..."
if apt purge -y rpcbind; then
  echo "✅ rpcbind removido com sucesso"
else
  echo "ℹ️ rpcbind não pode ser removido, mascarando o(s) serviço(s)..."
  systemctl mask rpcbind.socket rpcbind.service
fi
