#!/bin/bash
# Remediação - Restringe o uso do comando 'su' ao grupo 'sudo'

echo "Restringindo acesso ao comando 'su'..."
sed -i '/^#auth\s\+required\s\+pam_wheel.so\s\+use_uid/s/^#//' /etc/pam.d/su
groupadd -f sudo
echo "✔ Acesso ao comando 'su' restrito ao grupo 'sudo'."
