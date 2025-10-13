#!/bin/bash
# Auditoria - Verifica se o login root via SSH está desabilitado

echo "Verificando se o login root via SSH está desabilitado..."
if grep -Ei '^PermitRootLogin\s+no' /etc/ssh/sshd_config &>/dev/null; then
    echo "** PASS **"
else
    echo "** FAIL **"
    echo "- Login root via SSH NÃO está desabilitado! Esperado: 'PermitRootLogin no'"
fi
