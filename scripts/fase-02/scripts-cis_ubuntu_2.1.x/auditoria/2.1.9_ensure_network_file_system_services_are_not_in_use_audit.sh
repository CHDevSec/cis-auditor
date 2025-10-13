#!/bin/bash
# Auditoria: Verifica se o serviço nfs-kernel-server está presente e ativo

echo "Verificando se o pacote nfs-kernel-server está instalado..."
dpkg-query -s nfs-kernel-server &>/dev/null && echo "❌ nfs-kernel-server está instalado" || echo "✅ nfs-kernel-server não está instalado"

echo "Verificando se o(s) serviço(s) está(ão) habilitado(s)..."
systemctl is-enabled nfs-server.service 2>/dev/null | grep 'enabled' && echo "❌ nfs-server.service habilitado"

echo "Verificando se o(s) serviço(s) está(ão) ativo(s)..."
systemctl is-active nfs-server.service 2>/dev/null | grep '^active' && echo "❌ nfs-server.service ativo"
