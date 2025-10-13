#!/bin/bash
# Remediação: Remove ou desativa o(s) serviço(s) vsftpd.service

echo "Parando o(s) serviço(s) vsftpd.service..."
systemctl stop vsftpd.service

echo "Tentando remover o pacote vsftpd..."
if apt purge -y vsftpd; then
  echo "✅ vsftpd removido com sucesso"
else
  echo "ℹ️ vsftpd não pode ser removido, mascarando o(s) serviço(s)..."
  systemctl mask vsftpd.service
fi
