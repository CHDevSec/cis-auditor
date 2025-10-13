#!/bin/bash
# Remediação: Remove ou desativa o(s) serviço(s) smbd.service

echo "Parando o(s) serviço(s) smbd.service..."
systemctl stop smbd.service

echo "Tentando remover o pacote samba..."
if apt purge -y samba; then
  echo "✅ samba removido com sucesso"
else
  echo "ℹ️ samba não pode ser removido, mascarando o(s) serviço(s)..."
  systemctl mask smbd.service
fi
