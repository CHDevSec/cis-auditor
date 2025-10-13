#!/bin/bash
# Verifica se todos os perfis estão em modo enforce
apparmor_status | grep "profiles are in enforce mode"
