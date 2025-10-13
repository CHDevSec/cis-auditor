#!/bin/bash
# Auditoria - Verifica se há senha configurada no GRUB

echo "Verificando se há senha no GRUB..."

if grep "^set superusers" /etc/grub.d/40_custom &>/dev/null && grep "password_pbkdf2" /etc/grub.d/40_custom &>/dev/null; then
    echo "** PASS **"
else
    echo "** FAIL **"
    echo "- Senha GRUB NÃO configurada!"
fi
