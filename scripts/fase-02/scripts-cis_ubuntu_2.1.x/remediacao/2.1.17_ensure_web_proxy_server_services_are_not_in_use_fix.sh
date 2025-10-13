#!/bin/bash
# Remediação: Remove ou desativa squid e serviços relacionados

echo 'Parando serviço(s)...'
systemctl stop squid.service

echo 'Removendo pacote(s)...'
if apt purge -y squid; then
  echo '✅ squid removido com sucesso'
else
  echo 'ℹ️ squid não pode ser removido.'
  systemctl mask squid.service
fi
