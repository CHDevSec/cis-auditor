#!/bin/bash
# Remediação - Habilita o ASLR permanentemente

echo "Habilitando ASLR..."
echo 2 > /proc/sys/kernel/randomize_va_space
sysctl -w kernel.randomize_va_space=2
echo "kernel.randomize_va_space = 2" >> /etc/sysctl.conf

echo "✔ ASLR habilitado."
