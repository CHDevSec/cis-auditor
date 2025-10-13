#!/bin/bash
# Adiciona regras de loopback ao UFW
ufw allow in on lo
ufw deny in from 127.0.0.0/8
