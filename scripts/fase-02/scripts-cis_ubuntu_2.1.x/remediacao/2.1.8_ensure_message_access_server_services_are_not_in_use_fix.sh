#!/bin/bash
# Remediação: Remove ou desativa o(s) serviço(s) dovecot.socket dovecot.service

echo "Parando o(s) serviço(s) dovecot.socket dovecot.service..."
systemctl stop dovecot.socket dovecot.service

echo "Tentando remover o pacote dovecot-imapd dovecot-pop3d..."
if apt purge -y dovecot-imapd dovecot-pop3d; then
  echo "✅ dovecot-imapd dovecot-pop3d removido com sucesso"
else
  echo "ℹ️ dovecot-imapd dovecot-pop3d não pode ser removido, mascarando o(s) serviço(s)..."
  systemctl mask dovecot.socket dovecot.service
fi
