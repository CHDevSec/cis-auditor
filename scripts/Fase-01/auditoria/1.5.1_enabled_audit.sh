#!/bin/bash
# Auditoria - Verifica se o ASLR está habilitado

echo "Verificando se ASLR está habilitado..."
aslr=$(cat /proc/sys/kernel/randomize_va_space)

if [[ $aslr -eq 2 ]]; then
    echo "** PASS **"
else
    echo "** FAIL **"
    echo "- ASLR não está habilitado corretamente. Valor encontrado: $aslr"
fi
