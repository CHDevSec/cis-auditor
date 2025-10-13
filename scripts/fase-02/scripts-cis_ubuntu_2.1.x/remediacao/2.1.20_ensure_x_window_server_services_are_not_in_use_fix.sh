#!/bin/bash
# Remediação: Remove ou desativa xserver-common

echo 'Removendo pacote(s)...'
if apt purge -y xserver-common; then
  echo '✅ xserver-common removido com sucesso'
else
  echo 'ℹ️ xserver-common não pode ser removido.'
fi
