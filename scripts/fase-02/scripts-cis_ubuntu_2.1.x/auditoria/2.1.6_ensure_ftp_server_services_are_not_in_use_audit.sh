#!/bin/bash
# Auditoria: Verifica se o serviço vsftpd está presente e ativo

echo "Verificando se o pacote vsftpd está instalado..."
dpkg-query -s vsftpd &>/dev/null && echo "❌ vsftpd está instalado" || echo "✅ vsftpd não está instalado"

echo "Verificando se o(s) serviço(s) está(ão) habilitado(s)..."
systemctl is-enabled vsftpd.service 2>/dev/null | grep '^enabled' && echo "❌ vsftpd.service habilitado"

echo "Verificando se o(s) serviço(s) está(ão) ativo(s)..."
systemctl is-active vsftpd.service 2>/dev/null | grep '^active' && echo "❌ vsftpd.service ativo"
