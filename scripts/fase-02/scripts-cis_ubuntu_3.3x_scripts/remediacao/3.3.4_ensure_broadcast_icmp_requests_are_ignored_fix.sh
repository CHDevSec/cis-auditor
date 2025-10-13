#!/bin/bash
# Remediação: Ignora solicitações ICMP para endereços broadcast

echo "Configurando para ignorar ICMP broadcast..."

sysctl -w net.ipv4.icmp_echo_ignore_broadcasts=1

echo 'net.ipv4.icmp_echo_ignore_broadcasts = 1' > /etc/sysctl.d/60-cis-icmp-broadcast.conf

sysctl --system
