#!/bin/bash
# Auditoria: Verifica se pacotes source-routed são rejeitados

echo "Verificando source routed packets..."

for param in net.ipv4.conf.all.accept_source_route net.ipv4.conf.default.accept_source_route net.ipv6.conf.all.accept_source_route net.ipv6.conf.default.accept_source_route; do
    val=$(sysctl $param | awk '{print $3}')
    [ "$val" -eq 0 ] && echo "✔ $param desabilitado" || echo "✘ $param habilitado"
done
