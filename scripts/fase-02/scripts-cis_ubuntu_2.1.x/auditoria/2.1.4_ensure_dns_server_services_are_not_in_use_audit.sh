#!/bin/bash
# Auditoria: Verifica se o serviço bind9 (DNS) está ativo

echo "Verificando se o bind9 está instalado..."
if dpkg-query -s bind9 &>/dev/null; then
  echo "❌ bind9 está instalado"
else
  echo "✅ bind9 não está instalado"
fi

echo "Verificando se o serviço bind9 está habilitado..."
systemctl is-enabled bind9.service 2>/dev/null | grep 'enabled' && echo "❌ Serviço habilitado"

echo "Verificando se o serviço bind9 está ativo..."
systemctl is-active bind9.service 2>/dev/null | grep '^active' && echo "❌ Serviço ativo"
