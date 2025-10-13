#!/bin/bash
# Remediação: Remove ou desativa o serviço dnsmasq

echo "Parando o serviço dnsmasq..."
systemctl stop dnsmasq.service

echo "Verificando dependências do dnsmasq..."
if apt purge -y dnsmasq; then
  echo "✅ dnsmasq removido com sucesso"
else
  echo "ℹ️ dnsmasq não pode ser removido, mascarando serviço..."
  systemctl mask dnsmasq.service
fi
