#!/bin/bash
# Remediação - Desabilita autenticação root via SSH

echo "Desabilitando autenticação root via SSH..."
sed -i 's/^#*PermitRootLogin.*/PermitRootLogin no/' /etc/ssh/sshd_config
systemctl restart sshd

echo "✔ Autenticação root via SSH desabilitada."
