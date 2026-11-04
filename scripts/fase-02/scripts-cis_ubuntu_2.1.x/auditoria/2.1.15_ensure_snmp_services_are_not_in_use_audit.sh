#!/bin/bash
# Auditoria: Verifica se o serviço snmpd está presente e ativo

echo "Verificando se o pacote snmpd está instalado..."
dpkg-query -s snmpd &>/dev/null && echo "❌ snmpd está instalado" || echo "✅ snmpd não está instalado"

echo "Verificando se o(s) serviço(s) está(ão) habilitado(s)..."
systemctl is-enabled snmpd.service 2>/dev/null | grep '^enabled' && echo "❌ snmpd.service habilitado"

echo "Verificando se o(s) serviço(s) está(ão) ativo(s)..."
systemctl is-active snmpd.service 2>/dev/null | grep '^active' && echo "❌ snmpd.service ativo"
