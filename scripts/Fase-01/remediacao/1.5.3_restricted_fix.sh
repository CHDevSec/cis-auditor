#!/bin/bash
# Remediação - Restringe core dumps

echo "Restringindo core dumps..."
echo "* hard core 0" >> /etc/security/limits.conf
echo "fs.suid_dumpable = 0" >> /etc/sysctl.conf
sysctl -w fs.suid_dumpable=0

echo "✔ Core dumps foram restringidos."
