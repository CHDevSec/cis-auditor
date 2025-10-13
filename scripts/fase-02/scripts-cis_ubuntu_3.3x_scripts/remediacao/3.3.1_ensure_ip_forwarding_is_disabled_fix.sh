#!/bin/bash
# Remediação: Desabilita IP forwarding (IPv4 e IPv6) e aplica imediatamente

echo "Desabilitando IP forwarding..."

sysctl -w net.ipv4.ip_forward=0
sysctl -w net.ipv6.conf.all.forwarding=0

# Persistência em /etc/sysctl.d
echo 'net.ipv4.ip_forward = 0' > /etc/sysctl.d/60-cis-ipv4-forwarding.conf
echo 'net.ipv6.conf.all.forwarding = 0' > /etc/sysctl.d/60-cis-ipv6-forwarding.conf

sysctl --system
