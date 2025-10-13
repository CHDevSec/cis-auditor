#!/bin/bash
# Remediação: Remove ou desativa o serviço autofs

echo "Parando o serviço autofs..."
systemctl stop autofs.service

echo "Verificando dependências do autofs..."
if apt purge -y autofs; then
  echo "✅ autofs removido com sucesso"
else
  echo "ℹ️ autofs não pode ser removido, mascarando serviço..."
  systemctl mask autofs.service
fi
