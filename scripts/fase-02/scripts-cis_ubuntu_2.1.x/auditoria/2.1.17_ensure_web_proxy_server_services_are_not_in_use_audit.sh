#!/bin/bash
# Auditoria: Verifica se o pacote squid está presente e se serviços relacionados estão ativos

echo "Verificando se o pacote squid está instalado..."
dpkg-query -s squid &>/dev/null && echo "❌ squid está instalado" || echo "✅ squid não está instalado"

echo "Verificando se o(s) serviço(s) está(ão) habilitado(s)..."
systemctl is-enabled squid.service 2>/dev/null | grep 'enabled' && echo "❌ squid.service habilitado"

echo "Verificando se o(s) serviço(s) está(ão) ativo(s)..."
systemctl is-active squid.service 2>/dev/null | grep '^active' && echo "❌ squid.service ativo"
