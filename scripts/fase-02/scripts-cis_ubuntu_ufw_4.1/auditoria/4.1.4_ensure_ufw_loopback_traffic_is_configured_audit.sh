#!/bin/bash
# Verifica se as regras de loopback estão configuradas
ufw status | grep -q "ALLOW IN.*127.0.0.1" && echo "✔ Regra de loopback configurada." || echo "✖ Regra de loopback ausente."
