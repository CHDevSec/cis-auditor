#!/bin/bash
# Auditoria: Verifica se o serviço ypserv está presente e ativo

echo "Verificando se o pacote ypserv está instalado..."
dpkg-query -s ypserv &>/dev/null && echo "❌ ypserv está instalado" || echo "✅ ypserv não está instalado"

echo "Verificando se o(s) serviço(s) está(ão) habilitado(s)..."
systemctl is-enabled ypserv.service 2>/dev/null | grep 'enabled' && echo "❌ ypserv.service habilitado"

echo "Verificando se o(s) serviço(s) está(ão) ativo(s)..."
systemctl is-active ypserv.service 2>/dev/null | grep '^active' && echo "❌ ypserv.service ativo"
