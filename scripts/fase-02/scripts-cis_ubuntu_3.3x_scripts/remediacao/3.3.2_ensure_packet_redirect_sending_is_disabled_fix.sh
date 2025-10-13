#!/bin/bash
# Remediação: Desabilita envio de ICMP redirects

echo "Desabilitando envio de ICMP redirects..."

sysctl -w net.ipv4.conf.all.send_redirects=0
sysctl -w net.ipv4.conf.default.send_redirects=0

echo 'net.ipv4.conf.all.send_redirects = 0' > /etc/sysctl.d/60-cis-send-redirects.conf
echo 'net.ipv4.conf.default.send_redirects = 0' >> /etc/sysctl.d/60-cis-send-redirects.conf

sysctl --system
