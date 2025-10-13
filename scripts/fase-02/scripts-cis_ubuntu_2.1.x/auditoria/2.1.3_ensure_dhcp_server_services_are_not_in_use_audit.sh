#!/bin/bash
# Auditoria: Verifica se os serviços DHCP estão ativos

echo "Verificando se o isc-dhcp-server está instalado..."
if dpkg-query -s isc-dhcp-server &>/dev/null; then
  echo "❌ isc-dhcp-server está instalado"
else
  echo "✅ isc-dhcp-server não está instalado"
fi

echo "Verificando se os serviços estão habilitados..."
systemctl is-enabled isc-dhcp-server.service isc-dhcp-server6.service 2>/dev/null | grep 'enabled' && echo "❌ Serviços habilitados"

echo "Verificando se os serviços estão ativos..."
systemctl is-active isc-dhcp-server.service isc-dhcp-server6.service 2>/dev/null | grep '^active' && echo "❌ Serviços ativos"
