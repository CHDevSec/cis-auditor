#!/bin/bash
# Coloca todos os perfis em modo enforce ou complain (preferencialmente enforce)
for profile in /etc/apparmor.d/*; do
  aa-enforce "$profile"
done
