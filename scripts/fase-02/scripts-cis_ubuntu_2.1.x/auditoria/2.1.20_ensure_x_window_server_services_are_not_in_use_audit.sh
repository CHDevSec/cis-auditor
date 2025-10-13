#!/bin/bash
# Auditoria: Verifica se o pacote xserver-common está presente 

echo "Verificando se o pacote xserver-common está instalado..."
dpkg-query -s xserver-common &>/dev/null && echo "❌ xserver-common está instalado" || echo "✅ xserver-common não está instalado"
