#!/bin/bash
# Remediação: Remove ou desativa o serviço avahi-daemon

echo "Parando o serviço avahi-daemon..."
systemctl stop avahi-daemon.socket avahi-daemon.service

echo "Verificando dependências do avahi-daemon..."
if apt purge -y avahi-daemon; then
  echo "✅ avahi-daemon removido com sucesso"
else
  echo "ℹ️ avahi-daemon não pode ser removido, mascarando serviços..."
  systemctl mask avahi-daemon.socket avahi-daemon.service
fi
