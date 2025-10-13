# CIS Ubuntu 22.04 LTS - Parâmetros de Rede (3.3.x)

Este pacote contém scripts de **auditoria** e **remediação** para os controles da seção **3.3.x** do benchmark **CIS Ubuntu 22.04 LTS**.

## Como usar

### Auditoria
Execute o script de auditoria correspondente:
```bash
bash scripts/auditoria/3.3.1_ensure_ip_forwarding_is_disabled_audit.sh
```

### Remediação
Execute o script de remediação correspondente com permissões de superusuário:
```bash
sudo bash scripts/remediacao/3.3.1_ensure_ip_forwarding_is_disabled_fix.sh
```

Todos os scripts seguem as recomendações do benchmark CIS e aplicam as configurações de forma persistente usando arquivos em `/etc/sysctl.d/`.

---

Desenvolvido para aplicação em ambientes de produção com rastreabilidade e segurança.
