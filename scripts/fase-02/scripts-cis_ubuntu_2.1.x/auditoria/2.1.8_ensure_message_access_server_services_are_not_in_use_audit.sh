#!/bin/bash
# Auditoria: Verifica se o serviço dovecot-imapd dovecot-pop3d está presente e ativo

echo "Verificando se o pacote dovecot-imapd dovecot-pop3d está instalado..."
dpkg-query -s dovecot-imapd &>/dev/null && echo "❌ dovecot-imapd dovecot-pop3d está instalado" || echo "✅ dovecot-imapd dovecot-pop3d não está instalado"

echo "Verificando se o(s) serviço(s) está(ão) habilitado(s)..."
systemctl is-enabled dovecot.socket dovecot.service 2>/dev/null | grep 'enabled' && echo "❌ dovecot.socket dovecot.service habilitado"

echo "Verificando se o(s) serviço(s) está(ão) ativo(s)..."
systemctl is-active dovecot.socket dovecot.service 2>/dev/null | grep '^active' && echo "❌ dovecot.socket dovecot.service ativo"
