#!/bin/bash
# Coloca todos os perfis AppArmor em modo enforce
for profile in /etc/apparmor.d/*; do
  aa-enforce "$profile"
done
