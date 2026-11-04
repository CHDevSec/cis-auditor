#!/bin/bash
# Auditoria: Verifica se o serviço cups está presente e ativo

echo "Verificando se o pacote cups está instalado..."
dpkg-query -s cups &>/dev/null && echo "❌ cups está instalado" || echo "✅ cups não está instalado"

echo "Verificando se o(s) serviço(s) está(ão) habilitado(s)..."
systemctl is-enabled cups.socket cups.service 2>/dev/null | grep '^enabled' && echo "❌ cups.socket cups.service habilitado"

echo "Verificando se o(s) serviço(s) está(ão) ativo(s)..."
systemctl is-active cups.socket cups.service 2>/dev/null | grep '^active' && echo "❌ cups.socket cups.service ativo"
