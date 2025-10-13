#!/bin/bash
# Remediação: Remove ou desativa xinetd e serviços relacionados

echo 'Parando serviço(s)...'
systemctl stop xinetd.service

echo 'Removendo pacote(s)...'
if apt purge -y xinetd; then
  echo '✅ xinetd removido com sucesso'
else
  echo 'ℹ️ xinetd não pode ser removido.'
  systemctl mask xinetd.service
fi
