#!/bin/bash
# Auditoria - Verifica se o SSH permite senhas vazias

echo "Verificando se SSH permite senhas vazias..."
if grep -Ei '^PermitEmptyPasswords\s+no' /etc/ssh/sshd_config &>/dev/null; then
    echo "** PASS **"
else
    echo "** FAIL **"
    echo "- SSH permite senhas vazias! Esperado: 'PermitEmptyPasswords no'"
fi
