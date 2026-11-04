# Security Policy

CIS Auditor changes security-relevant configuration, so a wrong check (a false `PASS`) or an unsafe remediation is treated as a security issue.

## Reporting

Please **do not open a public issue**. Use GitHub's private reporting instead:
**Security → Report a vulnerability** on this repository.

Include the control ID, the Ubuntu version, what you expected and what happened. You will get an answer within 7 days.

## Scope

- Audit scripts that report `PASS` on a non-compliant system.
- Audit scripts that modify the system (they must be read-only).
- Remediations that open access, lock administrators out without warning, or destroy configuration.
- Command injection through file names, hostnames or script output in the engine or the HTML report.

## Supported versions

Only the latest release receives fixes.
