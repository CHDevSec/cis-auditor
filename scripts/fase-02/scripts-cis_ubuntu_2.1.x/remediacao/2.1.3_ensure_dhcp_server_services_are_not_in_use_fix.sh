#!/bin/bash
# Remediação: Remove ou desativa os serviços DHCP

echo "Parando serviços isc-dhcp-server..."
systemctl stop isc-dhcp-server.service isc-dhcp-server6.service

echo "Verificando dependências do isc-dhcp-server..."
if apt purge -y isc-dhcp-server; then
  echo "✅ isc-dhcp-server removido com sucesso"
else
  echo "ℹ️ isc-dhcp-server não pode ser removido, mascarando serviços..."
  systemctl mask isc-dhcp-server isc-dhcp-server6.service
fi
