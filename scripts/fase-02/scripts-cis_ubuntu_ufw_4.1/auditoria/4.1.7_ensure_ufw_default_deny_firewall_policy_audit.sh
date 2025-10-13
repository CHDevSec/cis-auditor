#!/bin/bash
# Verifica se a política padrão do UFW é "deny"
ufw status verbose | grep "Default:" | grep -q "deny" && echo "✔ Política padrão é deny." || echo "✖ Política padrão não é deny."
