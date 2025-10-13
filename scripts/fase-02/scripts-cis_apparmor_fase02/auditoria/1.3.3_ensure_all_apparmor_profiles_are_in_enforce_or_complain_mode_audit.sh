#!/bin/bash
# Verifica se todos os perfis AppArmor estão em modo enforce ou complain
apparmor_status | grep "profiles are in enforce mode"
apparmor_status | grep "profiles are in complain mode"
