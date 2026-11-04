#!/bin/bash
# Auditoria: Verifica se o serviço rsync está presente e ativo

echo "Verificando se o pacote rsync está instalado..."
dpkg-query -s rsync &>/dev/null && echo "❌ rsync está instalado" || echo "✅ rsync não está instalado"

echo "Verificando se o(s) serviço(s) está(ão) habilitado(s)..."
systemctl is-enabled rsync.service 2>/dev/null | grep '^enabled' && echo "❌ rsync.service habilitado"

echo "Verificando se o(s) serviço(s) está(ão) ativo(s)..."
systemctl is-active rsync.service 2>/dev/null | grep '^active' && echo "❌ rsync.service ativo"
