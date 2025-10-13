#!/bin/bash
# Adiciona regra de bloqueio para portas abertas sem regra
for port in $(ss -tuln | awk '($5!~/%lo:/ && $5!~/127.0.0.1:/ && $5!~/\[?::1\]?:/) {split($5, a, ":"); print a[2]}' | sort -u); do
  ufw status verbose | grep -q "$port" || ufw deny in "$port"
done
