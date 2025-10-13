#!/bin/bash
# Remediação: Remove ou desativa o serviço bind9

echo "Parando o serviço bind9..."
systemctl stop bind9.service

echo "Verificando dependências do bind9..."
if apt purge -y bind9; then
  echo "✅ bind9 removido com sucesso"
else
  echo "ℹ️ bind9 não pode ser removido, mascarando serviço..."
  systemctl mask bind9.service
fi
