#!/bin/bash

echo "🧹 Limpando arquivos JSON antigos da pasta results..."
find results/ -type f -name "audit-results-*" -delete
echo "✅ Arquivos audit-results-* removidos com sucesso!"
