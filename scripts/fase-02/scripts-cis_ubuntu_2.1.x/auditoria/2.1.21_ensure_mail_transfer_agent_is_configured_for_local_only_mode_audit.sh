#!/bin/bash
# Auditoria: Verifica se o Postfix está escutando somente em loopback

result=$(postconf -n inet_interfaces)
ports=("25" "465" "587")
l_output=""
l_output2=""

if [[ "$result" != "inet_interfaces = all" ]]; then
  for port in "${ports[@]}"; do
    if ss -plntu | grep -P -- ":$port\b" | grep -Pvq '\h+(127\.0\.0\.1|\[?::1\]?):$port\b'; then
      l_output2+="- Porta $port está escutando em interface não-loopback
"
    else
      l_output+="- Porta $port está configurada corretamente
"
    fi
  done
else
  l_output2+="- Postfix está configurado para escutar em todas interfaces
"
fi

if [[ -z "$l_output2" ]]; then
  echo -e "** PASS **
$l_output"
else
  echo -e "** FAIL **
$l_output2"
  [[ -n "$l_output" ]] && echo -e "
Corretamente configurado:
$l_output"
fi
