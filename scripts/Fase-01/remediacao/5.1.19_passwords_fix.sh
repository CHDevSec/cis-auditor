#!/bin/bash
# Remediação - Impede o uso de senhas vazias no SSH

echo "Impedindo uso de senhas vazias no SSH..."
sed -i 's/^#*PermitEmptyPasswords.*/PermitEmptyPasswords no/' /etc/ssh/sshd_config
systemctl restart sshd

echo "✔ Senhas vazias desabilitadas no SSH."
