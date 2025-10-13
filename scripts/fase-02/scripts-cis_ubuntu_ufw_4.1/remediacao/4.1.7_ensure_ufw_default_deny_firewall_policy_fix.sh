#!/bin/bash
# Aplica política padrão para negar conexões
ufw default deny incoming
ufw default deny outgoing
ufw default deny routed
