#!/bin/bash
# Auditoria - Verifica se a autenticação root via SSH está desabilitada

echo "Verificando se autenticação root via SSH está desabilitada..."
if grep -Ei '^PermitRootLogin\s+no' /etc/ssh/sshd_config &>/dev/null; then
    echo "** PASS **"
else
    echo "** FAIL **"
    echo "- Autenticação root via SSH NÃO está desabilitada! Esperado: 'PermitRootLogin no'"
fi
