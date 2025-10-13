#!/bin/bash
# Remediação: Remove ou desativa o(s) serviço(s) snmpd.service

echo "Parando o(s) serviço(s) snmpd.service..."
systemctl stop snmpd.service

echo "Tentando remover o pacote snmpd..."
if apt purge -y snmpd; then
  echo "✅ snmpd removido com sucesso"
else
  echo "ℹ️ snmpd não pode ser removido, mascarando o(s) serviço(s)..."
  systemctl mask snmpd.service
fi
