#!/bin/bash
# Auditoria: Verifica se o serviço samba está presente e ativo

echo "Verificando se o pacote samba está instalado..."
dpkg-query -s samba &>/dev/null && echo "❌ samba está instalado" || echo "✅ samba não está instalado"

echo "Verificando se o(s) serviço(s) está(ão) habilitado(s)..."
systemctl is-enabled smbd.service 2>/dev/null | grep '^enabled' && echo "❌ smbd.service habilitado"

echo "Verificando se o(s) serviço(s) está(ão) ativo(s)..."
systemctl is-active smbd.service 2>/dev/null | grep '^active' && echo "❌ smbd.service ativo"
