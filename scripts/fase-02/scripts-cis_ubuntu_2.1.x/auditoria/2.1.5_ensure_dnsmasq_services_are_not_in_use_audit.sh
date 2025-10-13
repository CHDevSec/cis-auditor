#!/bin/bash
# Auditoria: Verifica se o serviço dnsmasq está ativo

echo "Verificando se o dnsmasq está instalado..."
if dpkg-query -s dnsmasq &>/dev/null; then
  echo "❌ dnsmasq está instalado"
else
  echo "✅ dnsmasq não está instalado"
fi

echo "Verificando se o serviço dnsmasq está habilitado..."
systemctl is-enabled dnsmasq.service 2>/dev/null | grep 'enabled' && echo "❌ Serviço habilitado"

echo "Verificando se o serviço dnsmasq está ativo..."
systemctl is-active dnsmasq.service 2>/dev/null | grep '^active' && echo "❌ Serviço ativo"
