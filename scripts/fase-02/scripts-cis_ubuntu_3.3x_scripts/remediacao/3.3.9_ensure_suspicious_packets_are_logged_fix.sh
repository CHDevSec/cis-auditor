#!/bin/bash
# Remediação: Habilita log de pacotes suspeitos

echo "Habilitando log de pacotes suspeitos..."

sysctl -w net.ipv4.conf.all.log_martians=1

echo 'net.ipv4.conf.all.log_martians = 1' > /etc/sysctl.d/60-cis-log-martians.conf

sysctl --system
