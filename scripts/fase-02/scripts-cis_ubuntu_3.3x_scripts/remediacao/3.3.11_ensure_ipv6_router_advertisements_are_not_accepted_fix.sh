#!/bin/bash
# Remediação: Desabilita aceitação de IPv6 Router Advertisements

echo "Desabilitando IPv6 Router Advertisements..."

params=(
  "net.ipv6.conf.all.accept_ra = 0"
  "net.ipv6.conf.default.accept_ra = 0"
)

for p in "${params[@]}"; do
  sysctl -w "${p}"
done

{
  for p in "${params[@]}"; do
    echo "$p"
  done
} > /etc/sysctl.d/60-cis-ipv6-ra.conf

sysctl --system
