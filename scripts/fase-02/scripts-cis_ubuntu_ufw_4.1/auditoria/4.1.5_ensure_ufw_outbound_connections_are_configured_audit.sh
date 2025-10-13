#!/bin/bash
# Verifica as regras de saída no UFW
ufw status verbose | grep "Outgoing"
