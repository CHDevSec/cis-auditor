#!/bin/bash
# Remediação - Configura senha no GRUB usando hash SHA-512

read -sp "Digite a senha desejada para o GRUB: " grub_password
echo
grub_hash=$(echo -e "$grub_password\n$grub_password" | grub-mkpasswd-pbkdf2 | grep "grub.pbkdf2" | awk '{print $7}')

echo "set superusers=\"root\"" > /etc/grub.d/40_custom
echo "password_pbkdf2 root $grub_hash" >> /etc/grub.d/40_custom

chmod 755 /etc/grub.d/40_custom
update-grub

echo "✔ Senha configurada no GRUB com sucesso."
