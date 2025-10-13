#!/bin/bash
# Auditoria: Verifica se o pacote tftpd-hpa está presente e se serviços relacionados estão ativos

echo "Verificando se o pacote tftpd-hpa está instalado..."
dpkg-query -s tftpd-hpa &>/dev/null && echo "❌ tftpd-hpa está instalado" || echo "✅ tftpd-hpa não está instalado"

echo "Verificando se o(s) serviço(s) está(ão) habilitado(s)..."
systemctl is-enabled tftpd-hpa.service 2>/dev/null | grep 'enabled' && echo "❌ tftpd-hpa.service habilitado"

echo "Verificando se o(s) serviço(s) está(ão) ativo(s)..."
systemctl is-active tftpd-hpa.service 2>/dev/null | grep '^active' && echo "❌ tftpd-hpa.service ativo"
