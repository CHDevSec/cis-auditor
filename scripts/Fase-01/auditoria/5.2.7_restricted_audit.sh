#!/bin/bash
# Auditoria - Verifica se o comando 'su' está restrito ao grupo 'sudo'

echo "Verificando restrição de acesso ao comando 'su'..."
if grep -E "^auth\s+required\s+pam_wheel.so\s+use_uid" /etc/pam.d/su &>/dev/null && getent group sudo &>/dev/null; then
    echo "** PASS **"
else
    echo "** FAIL **"
    echo "- O acesso ao comando 'su' NÃO está restrito corretamente ao grupo 'sudo'"
fi
