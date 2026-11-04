# Contributing

Thanks for helping! New controls, fixes to existing checks and safer remediations are all welcome.

## Setup

```bash
git clone https://github.com/CHDevSec/cis-auditor.git && cd cis-auditor
make lint test        # go vet, bash -n on every script, Go tests
```

Test audits and remediations on a disposable Ubuntu 22.04 VM or container, never on your workstation.

## Adding a control

Each control is three things with the same CIS ID:

| File | Rules |
|---|---|
| `scripts/<phase>/auditoria/<ID>_<name>_audit.sh` | **Read-only.** No writes, no service restarts, no package installs. Prints the verdict. |
| `scripts/<phase>/remediacao/<ID>_<name>_fix.sh` | Changes the system. Should be idempotent (check before appending) and print what it did. |
| entry in `configs/profiles/<profile>.yaml` | `id`, `category`, `description` (the CIS title), `remediate` (one-line hint), `level` (`server`/`workstation`), `script_audit`, `script_fix` |

### Audit script output contract

```bash
#!/bin/bash
# <ID> — <what is checked>
echo "Verificando <thing>..."          # optional header, ignored
if <compliant>; then
  echo "✅ <what is right>"            # PASS marker: ✅ ✔ or ** PASS **
else
  echo "❌ <what is wrong and the value found>"   # FAIL marker: ❌ ✘ ✖ or ** FAIL **
fi
```

- Any FAIL line makes the control `FAIL`; its text becomes the report detail. Lines starting with `- ` are also added as details.
- No marker at all means `MANUAL`: use it for checks that need a human decision (e.g. "only approved services listen") and print the evidence.
- The exit code does not matter; do not `exit 1` to signal failure.

Then:

```bash
make docs                       # regenerate docs/CONTROLS.md and the folder READMEs
make audit_id ID=<ID>           # see the raw output
make lint test
```

## Pull requests

- One control or one fix per PR, with the CIS ID in the title (`feat(3.3.12): ...`, `fix(2.1.4): ...`).
- Mention which Ubuntu version you tested on and paste the audit output before/after the fix.
- Keep generated files in sync (`make docs`) — CI fails otherwise.
