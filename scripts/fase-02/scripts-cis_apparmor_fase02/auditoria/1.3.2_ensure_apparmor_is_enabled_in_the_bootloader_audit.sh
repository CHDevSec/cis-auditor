#!/bin/bash
# Verifica se o AppArmor está ativado na linha do GRUB
if grep -q 'apparmor=1 security=apparmor' /etc/default/grub; then
  echo "✅ AppArmor está habilitado no bootloader."
else
  echo "❌ AppArmor NÃO está habilitado no bootloader."
fi
