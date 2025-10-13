#!/bin/bash
# Remediação: Remove ou desativa o(s) serviço(s) ypserv.service

echo "Parando o(s) serviço(s) ypserv.service..."
systemctl stop ypserv.service

echo "Tentando remover o pacote ypserv..."
if apt purge -y ypserv; then
  echo "✅ ypserv removido com sucesso"
else
  echo "ℹ️ ypserv não pode ser removido, mascarando o(s) serviço(s)..."
  systemctl mask ypserv.service
fi
