#!/bin/bash
# Auditoria - Verifica se o algoritmo de hash das senhas é SHA-512

echo "Verificando algoritmo de hash de senhas..."
if grep -E "^ENCRYPT_METHOD\s+SHA512" /etc/login.defs &>/dev/null; then
    echo "** PASS **"
else
    echo "** FAIL **"
    echo "- Algoritmo SHA-512 NÃO está configurado corretamente em /etc/login.defs"
fi
