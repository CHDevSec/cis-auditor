#!/bin/bash
# Remediação: Habilita TCP SYN cookies para mitigar ataques SYN flood

echo "Habilitando TCP SYN cookies..."

sysctl -w net.ipv4.tcp_syncookies=1

echo 'net.ipv4.tcp_syncookies = 1' > /etc/sysctl.d/60-cis-syn-cookies.conf

sysctl --system
