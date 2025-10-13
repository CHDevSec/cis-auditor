#!/bin/bash
# Verifica se o AppArmor está instalado
if dpkg -s apparmor &>/dev/null; then
  echo "✅ AppArmor está instalado."
else
  echo "❌ AppArmor NÃO está instalado."
fi
