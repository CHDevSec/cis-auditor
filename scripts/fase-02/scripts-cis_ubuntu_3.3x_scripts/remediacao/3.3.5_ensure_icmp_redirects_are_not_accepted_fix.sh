#!/bin/bash
# Remediação: Desabilita ICMP redirects (IPv4 e IPv6)

echo "Desabilitando ICMP redirects..."

params=(
  "net.ipv4.conf.all.accept_redirects = 0"
  "net.ipv4.conf.default.accept_redirects = 0"
  "net.ipv6.conf.all.accept_redirects = 0"
  "net.ipv6.conf.default.accept_redirects = 0"
)

for p in "${params[@]}"; do
  sysctl -w "${p}"
done

{
  for p in "${params[@]}"; do
    echo "$p"
  done
} > /etc/sysctl.d/60-cis-icmp-redirects.conf

sysctl --system
