#!/bin/bash
# Remediação: Configura para ignorar respostas ICMP inválidas

echo "Ignorando respostas ICMP inválidas..."

sysctl -w net.ipv4.icmp_ignore_bogus_error_responses=1

echo 'net.ipv4.icmp_ignore_bogus_error_responses = 1' > /etc/sysctl.d/60-cis-icmp-bogus.conf

sysctl --system
