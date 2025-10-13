#!/bin/bash
# Remediação - Desabilita login root via SSH

echo "Desabilitando login root via SSH..."
sed -i 's/^#*PermitRootLogin.*/PermitRootLogin no/' /etc/ssh/sshd_config
systemctl restart sshd

echo "✔ Login root via SSH desabilitado."
