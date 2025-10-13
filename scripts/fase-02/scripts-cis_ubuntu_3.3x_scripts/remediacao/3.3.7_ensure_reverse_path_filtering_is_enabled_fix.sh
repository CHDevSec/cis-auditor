#!/bin/bash
# Remediação: Habilita reverse path filtering

echo "Habilitando reverse path filtering..."

sysctl -w net.ipv4.conf.all.rp_filter=1
sysctl -w net.ipv4.conf.default.rp_filter=1

echo 'net.ipv4.conf.all.rp_filter = 1' > /etc/sysctl.d/60-cis-rp_filter.conf
echo 'net.ipv4.conf.default.rp_filter = 1' >> /etc/sysctl.d/60-cis-rp_filter.conf

sysctl --system
