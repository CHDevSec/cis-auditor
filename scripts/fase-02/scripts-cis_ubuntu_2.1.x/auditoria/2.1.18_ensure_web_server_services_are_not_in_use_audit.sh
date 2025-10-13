#!/bin/bash
# Auditoria: Verifica se o pacote apache2 nginx está presente e se serviços relacionados estão ativos

echo "Verificando se o pacote apache2 nginx está instalado..."
dpkg-query -s apache2 &>/dev/null && echo "❌ apache2 nginx está instalado" || echo "✅ apache2 nginx não está instalado"

echo "Verificando se o(s) serviço(s) está(ão) habilitado(s)..."
systemctl is-enabled apache2.socket apache2.service nginx.service 2>/dev/null | grep 'enabled' && echo "❌ apache2.socket apache2.service nginx.service habilitado"

echo "Verificando se o(s) serviço(s) está(ão) ativo(s)..."
systemctl is-active apache2.socket apache2.service nginx.service 2>/dev/null | grep '^active' && echo "❌ apache2.socket apache2.service nginx.service ativo"
