# Scripts de Auditoria e Remediação - CIS Ubuntu 22.04 - Bloco 4.1 (UFW)

Este pacote contém os scripts de **auditoria** e **remediação** para os controles do benchmark CIS Ubuntu 22.04 relacionados ao firewall UFW (bloco 4.1).

## Como executar

### Auditoria
```bash
cd scripts/auditoria
chmod +x *.sh
./4.1.1_ensure_ufw_is_installed_audit.sh
```

### Remediação
```bash
cd scripts/remediacao
chmod +x *.sh
./4.1.1_ensure_ufw_is_installed_fix.sh
```

Repita para os demais scripts conforme necessário.

## Controles abordados
- 4.1.1: Ensure ufw is installed
- 4.1.2: Ensure iptables-persistent is not installed with ufw
- 4.1.3: Ensure ufw service is enabled
- 4.1.4: Ensure ufw loopback traffic is configured
- 4.1.5: Ensure ufw outbound connections are configured
- 4.1.6: Ensure ufw firewall rules exist for all open ports
- 4.1.7: Ensure ufw default deny firewall policy
