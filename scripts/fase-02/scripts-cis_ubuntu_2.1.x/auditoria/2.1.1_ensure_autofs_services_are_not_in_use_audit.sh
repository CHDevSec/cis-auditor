#!/bin/bash
# Auditoria: Verifica se o serviço autofs está instalado e ativo

echo "Verificando se o autofs está instalado..."
if dpkg-query -s autofs &>/dev/null; then
  echo "❌ autofs está instalado"
else
  echo "✅ autofs não está instalado"
fi

echo "Verificando se o serviço autofs está habilitado..."
systemctl is-enabled autofs.service 2>/dev/null | grep '^enabled' && echo "❌ Serviço habilitado"

echo "Verificando se o serviço autofs está ativo..."
systemctl is-active autofs.service 2>/dev/null | grep '^active' && echo "❌ Serviço ativo"
