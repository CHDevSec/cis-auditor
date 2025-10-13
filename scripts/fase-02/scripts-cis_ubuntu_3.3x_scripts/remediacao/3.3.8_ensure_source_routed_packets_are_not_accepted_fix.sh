#!/bin/bash
# Remediação: Rejeita pacotes source-routed

echo "Rejeitando source routed packets..."

params=(
  "net.ipv4.conf.all.accept_source_route = 0"
  "net.ipv4.conf.default.accept_source_route = 0"
  "net.ipv6.conf.all.accept_source_route = 0"
  "net.ipv6.conf.default.accept_source_route = 0"
)

for p in "${params[@]}"; do
  sysctl -w "${p}"
done

{
  for p in "${params[@]}"; do
    echo "$p"
  done
} > /etc/sysctl.d/60-cis-source-route.conf

sysctl --system
