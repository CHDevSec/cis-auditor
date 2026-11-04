#!/bin/bash
# Auditoria: Verifica se o serviço slapd está presente e ativo

echo "Verificando se o pacote slapd está instalado..."
dpkg-query -s slapd &>/dev/null && echo "❌ slapd está instalado" || echo "✅ slapd não está instalado"

echo "Verificando se o(s) serviço(s) está(ão) habilitado(s)..."
systemctl is-enabled slapd.service 2>/dev/null | grep '^enabled' && echo "❌ slapd.service habilitado"

echo "Verificando se o(s) serviço(s) está(ão) ativo(s)..."
systemctl is-active slapd.service 2>/dev/null | grep '^active' && echo "❌ slapd.service ativo"
