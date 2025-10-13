#!/bin/bash
# Remediação: Desabilita secure ICMP redirects

echo "Desabilitando secure ICMP redirects..."

params=(
  "net.ipv4.conf.all.secure_redirects = 0"
  "net.ipv4.conf.default.secure_redirects = 0"
)

for p in "${params[@]}"; do
  sysctl -w "${p}"
done

{
  for p in "${params[@]}"; do
    echo "$p"
  done
} > /etc/sysctl.d/60-cis-secure-redirects.conf

sysctl --system
