#!/bin/bash
# Remediação: Remove ou desativa tftpd-hpa e serviços relacionados

echo 'Parando serviço(s)...'
systemctl stop tftpd-hpa.service

echo 'Removendo pacote(s)...'
if apt purge -y tftpd-hpa; then
  echo '✅ tftpd-hpa removido com sucesso'
else
  echo 'ℹ️ tftpd-hpa não pode ser removido.'
  systemctl mask tftpd-hpa.service
fi
