#!/bin/bash
# Remediação: Orientação para bloquear serviços não aprovados

echo "⚠️ Este script é genérico e requer ajuste manual para o seu ambiente."
echo "Para desativar um serviço não aprovado, utilize o exemplo abaixo:"
echo ""
echo "# systemctl stop <serviço>.service <serviço>.socket"
echo "# apt purge <pacote>"
echo "# ou, se houver dependências:"
echo "# systemctl mask <serviço>.service <serviço>.socket"
