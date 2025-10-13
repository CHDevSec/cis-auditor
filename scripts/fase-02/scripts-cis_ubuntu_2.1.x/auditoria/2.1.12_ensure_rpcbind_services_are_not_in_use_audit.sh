#!/bin/bash
# Auditoria: Verifica se o serviço rpcbind está presente e ativo

echo "Verificando se o pacote rpcbind está instalado..."
dpkg-query -s rpcbind &>/dev/null && echo "❌ rpcbind está instalado" || echo "✅ rpcbind não está instalado"

echo "Verificando se o(s) serviço(s) está(ão) habilitado(s)..."
systemctl is-enabled rpcbind.socket rpcbind.service 2>/dev/null | grep 'enabled' && echo "❌ rpcbind.socket rpcbind.service habilitado"

echo "Verificando se o(s) serviço(s) está(ão) ativo(s)..."
systemctl is-active rpcbind.socket rpcbind.service 2>/dev/null | grep '^active' && echo "❌ rpcbind.socket rpcbind.service ativo"
