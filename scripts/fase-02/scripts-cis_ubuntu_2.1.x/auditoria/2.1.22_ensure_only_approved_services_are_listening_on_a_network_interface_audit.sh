#!/bin/bash
# Auditoria: Verifica todos os serviços escutando em interfaces de rede

echo "Listando serviços escutando em interfaces de rede..."
ss -plntu

echo "⚠️ Verifique manualmente se todos os serviços listados são aprovados pelas políticas locais."
