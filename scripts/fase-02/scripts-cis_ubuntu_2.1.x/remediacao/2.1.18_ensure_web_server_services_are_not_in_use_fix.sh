#!/bin/bash
# Remediação: Remove ou desativa apache2 nginx e serviços relacionados

echo 'Parando serviço(s)...'
systemctl stop apache2.socket apache2.service nginx.service

echo 'Removendo pacote(s)...'
if apt purge -y apache2 nginx; then
  echo '✅ apache2 nginx removido com sucesso'
else
  echo 'ℹ️ apache2 nginx não pode ser removido.'
  systemctl mask apache2.socket apache2.service nginx.service
fi
