#!/bin/bash
# Auditoria - Verifica se core dumps estão restritos

echo "Verificando se core dumps estão restritos..."
if grep -E "^\* hard core 0" /etc/security/limits.conf &>/dev/null; then
    echo "** PASS **"
else
    echo "** FAIL **"
    echo "- Core dumps NÃO estão restritos! Linha esperada: '* hard core 0'"
fi
