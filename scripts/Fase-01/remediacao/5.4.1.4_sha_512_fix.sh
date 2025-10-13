#!/bin/bash
# Remediação - Configura SHA-512 como algoritmo de hash

echo "Configurando SHA-512 como algoritmo de hash..."
sed -i 's/^#*ENCRYPT_METHOD.*/ENCRYPT_METHOD SHA512/' /etc/login.defs

echo "✔ SHA-512 configurado com sucesso."
