#!/bin/bash
# Remediação: Configura o Postfix para modo local-only

echo "Configurando o Postfix para aceitar conexões apenas de localhost..."
sed -i 's/^inet_interfaces = .*/inet_interfaces = loopback-only/' /etc/postfix/main.cf

echo "Reiniciando o serviço postfix..."
systemctl restart postfix
