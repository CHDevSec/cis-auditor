#!/bin/bash
# Auditoria: Verifica se o serviço avahi-daemon está instalado e ativo

echo "Verificando se o avahi-daemon está instalado..."
if dpkg-query -s avahi-daemon &>/dev/null; then
  echo "❌ avahi-daemon está instalado"
else
  echo "✅ avahi-daemon não está instalado"
fi

echo "Verificando se o serviço e socket estão habilitados..."
systemctl is-enabled avahi-daemon.socket avahi-daemon.service 2>/dev/null | grep 'enabled' && echo "❌ Serviço habilitado"

echo "Verificando se o serviço e socket estão ativos..."
systemctl is-active avahi-daemon.socket avahi-daemon.service 2>/dev/null | grep '^active' && echo "❌ Serviço ativo"
