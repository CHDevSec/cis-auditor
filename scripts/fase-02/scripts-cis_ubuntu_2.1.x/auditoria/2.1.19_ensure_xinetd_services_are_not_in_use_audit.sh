#!/bin/bash
# Auditoria: Verifica se o pacote xinetd está presente e se serviços relacionados estão ativos

echo "Verificando se o pacote xinetd está instalado..."
dpkg-query -s xinetd &>/dev/null && echo "❌ xinetd está instalado" || echo "✅ xinetd não está instalado"

echo "Verificando se o(s) serviço(s) está(ão) habilitado(s)..."
systemctl is-enabled xinetd.service 2>/dev/null | grep 'enabled' && echo "❌ xinetd.service habilitado"

echo "Verificando se o(s) serviço(s) está(ão) ativo(s)..."
systemctl is-active xinetd.service 2>/dev/null | grep '^active' && echo "❌ xinetd.service ativo"
