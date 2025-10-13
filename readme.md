# 🔐 CIS Auditor - Linux Hardening Framework

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Go Version](https://img.shields.io/badge/Go-1.18+-00ADD8?logo=go)](https://golang.org)
[![CIS Benchmark](https://img.shields.io/badge/CIS-Ubuntu%2022.04-orange)](https://www.cisecurity.org/)

Enterprise-grade automated auditing and remediation toolkit for Linux systems based on CIS (Center for Internet Security) benchmarks. Designed for security engineers, DevSecOps teams, and compliance-driven environments.

---

## 🎯 Overview

This framework automates the assessment and hardening of Ubuntu 22.04 LTS systems against CIS Benchmark controls. It provides:

- **Automated Security Audits**: Evaluate system configurations against industry-standard baselines
- **One-Click Remediation**: Apply security hardening measures with minimal manual intervention
- **Detailed Reporting**: Generate comprehensive HTML/JSON reports for compliance documentation
- **Modular Architecture**: Extensible design supporting custom security profiles and controls

**Use Cases:**
- Enterprise security baseline enforcement
- SOC/IR compliance validation
- Continuous security monitoring in CI/CD pipelines
- Security training and red team environments
- Third-party security assessments

---

## 📋 Prerequisites

### System Requirements
- **Operating System**: Ubuntu 22.04 LTS (tested) or compatible Debian-based distributions
- **Go Runtime**: 1.18 or higher
- **Python**: 3.8+
- **Bash**: 4.0+
- **Privileges**: Root or sudo access for remediation tasks

### Installation Dependencies
```bash
# Update package index
sudo apt update

# Install required packages
sudo apt install -y golang-go python3 python3-pip bash

# Verify installations
go version
python3 --version
bash --version
```

---

## 📁 Project Architecture

```
cis-auditor/
├── cmd/                      # Application entrypoint (main.go)
├── configs/
│   └── profiles/             # YAML security profiles (Phase 01 & Phase 02)
├── internal/
│   └── auditor/              # Core audit engine (Go)
├── scripts/
│   ├── Fase-01/              # Phase 01 controls (Initial Setup)
│   │   ├── auditoria/        # Audit validation scripts
│   │   └── remediacao/       # Remediation implementation scripts
│   ├── Fase-02/              # Phase 02 controls (Services)
│   │   ├── auditoria/        # Audit validation scripts
│   │   └── remediacao/       # Remediation implementation scripts
│   └── generate_report.py    # HTML report generator
├── results/                  # Output directory (JSON/HTML reports)
├── Makefile                  # Build and execution automation
├── go.mod                    # Go module dependencies
└── README.md                 # Project documentation
```

### Design Principles
- **Separation of Concerns**: Audit logic isolated from remediation
- **Idempotency**: Safe to run multiple times without side effects
- **Audit Trail**: All actions logged with timestamps and results
- **Non-Destructive**: Audit mode never modifies system state

---

## 🚀 Quick Start

### 1. Clone the Repository
```bash
git clone https://github.com/yourusername/cis-auditor.git
cd cis-auditor
```

### 2. Set Execution Permissions
```bash
chmod +x scripts/Fase-01/auditoria/*.sh
chmod +x scripts/Fase-01/remediacao/*.sh
chmod +x scripts/Fase-02/auditoria/*.sh
chmod +x scripts/Fase-02/remediacao/*.sh
chmod +x scripts/generate_report.py
```

### 3. Build the Application
```bash
make build
```

### 4. Run Your First Audit
```bash
sudo make audit
```

Results will be generated in `results/cis-audit-report.html`

---

## 🛠️ Usage Guide

### Full Security Assessments

#### Phase 01 Audit (Initial Setup & Filesystem)
```bash
sudo make audit
```
Evaluates foundational security controls including:
- Filesystem configuration and mount options
- Boot loader security (GRUB)
- Mandatory access controls (AppArmor/SELinux)
- Process hardening settings

#### Phase 02 Audit (Services & Network)
```bash
sudo make audit_fase02
```
Evaluates service-level controls including:
- Network service configurations
- Access control services (SSH, PAM)
- System maintenance protocols

### Targeted Assessments

#### Audit Single Control
```bash
sudo make audit_id ID=1.1.3
```
Executes audit for specific CIS control (e.g., 1.1.3 - Ensure nodev option set on /tmp)

### Remediation Operations

#### Apply Single Remediation
```bash
sudo make fix_id ID=1.5.1
```
**⚠️ Warning**: Always audit before remediation. Review changes in test environment first.

#### Apply All Phase 01 Remediations
```bash
sudo make fix_all
```
**⚠️ Critical**: This will modify system configuration. Backup and test thoroughly.

### Reporting

#### Generate HTML Report (from existing JSON)
```bash
make report
```

Output location: `results/cis-audit-report.html`

---

## 📊 Sample Output

### JSON Report Structure
```json
{
  "timestamp": "2025-10-12T14:23:45Z",
  "hostname": "prod-web-01",
  "total_controls": 143,
  "passed": 128,
  "failed": 12,
  "manual": 3,
  "controls": [
    {
      "id": "1.1.3",
      "description": "Ensure nodev option set on /tmp partition",
      "status": "PASS",
      "severity": "HIGH",
      "remediation_available": true
    }
  ]
}
```

### HTML Report Features
- Executive summary dashboard
- Control-by-control breakdown with severity ratings
- Pass/Fail statistics with visual indicators
- Remediation recommendations
- Compliance scoring

---

## 🎓 Use Cases & Scenarios

### Enterprise Security Operations
- **Baseline Hardening**: Deploy consistent security baselines across server fleets
- **Compliance Audits**: Generate evidence for SOC 2, ISO 27001, PCI-DSS assessments
- **Drift Detection**: Identify configuration changes that deviate from security policy

### DevSecOps Integration
```bash
# CI/CD pipeline example
- name: Security Baseline Audit
  run: |
    make audit
    if [ $? -ne 0 ]; then
      echo "Security audit failed - blocking deployment"
      exit 1
    fi
```

### Security Training & Labs
- Hands-on CIS Benchmark training exercises
- Red team infrastructure hardening
- Blue team defensive posture assessment

### Managed Service Providers (MSPs)
- Multi-tenant security validation
- Customer compliance reporting
- Automated security reviews

---

## 🔧 Advanced Configuration

### Custom Security Profiles

Create custom YAML profiles in `configs/profiles/`:

```yaml
# configs/profiles/custom-profile.yaml
name: "Custom High-Security Profile"
benchmark: "CIS Ubuntu 22.04 LTS"
level: 2
controls:
  - id: "1.1.3"
    enabled: true
    severity: "HIGH"
    auto_remediate: false
```

### Environment Variables

```bash
# Set custom output directory
export CIS_OUTPUT_DIR="/var/log/security-audits"

# Enable verbose logging
export CIS_DEBUG=true

# Dry-run mode (audit only, no remediation)
export CIS_DRY_RUN=true
```

---

## 🤝 Contributing

Contributions are welcome! This project follows secure development practices:

### Development Workflow
1. Fork the repository
2. Create a feature branch (`git checkout -b feature/new-control`)
3. Add tests for new controls
4. Commit with descriptive messages (`git commit -m "Add CIS 2.3.1 control"`)
5. Push to your fork (`git push origin feature/new-control`)
6. Open a Pull Request with detailed description

### Control Development Guidelines
- Each control must have both audit and remediation scripts
- Include rollback procedures for remediation
- Document expected behavior and edge cases
- Test on clean Ubuntu 22.04 LTS installation
- Follow CIS Benchmark official documentation

---

## 📜 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

## ⚠️ Disclaimer

This tool modifies system security configurations. Always:
- Test in non-production environments first
- Maintain backups before remediation
- Review changes in audit mode
- Understand the impact of each control
- Consult with system administrators

The authors assume no liability for system changes or operational impacts.

---

## 📚 References

- [CIS Ubuntu Linux 22.04 LTS Benchmark](https://www.cisecurity.org/benchmark/ubuntu_linux)
- [NIST Cybersecurity Framework](https://www.nist.gov/cyberframework)
- [Linux Security Hardening Guide](https://www.kernel.org/doc/html/latest/admin-guide/security.html)

---

## 👨‍💻 Author

**Caio Henrique**  
Security Engineer | Software Architect  
Specializing in Infrastructure Security, Compliance Automation & DevSecOps

[![LinkedIn](https://img.shields.io/badge/LinkedIn-Connect-blue?logo=linkedin)](https://linkedin.com/in/yourprofile)
[![GitHub](https://img.shields.io/badge/GitHub-Follow-black?logo=github)](https://github.com/yourprofile)

---

## 🙏 Acknowledgments

- Center for Internet Security (CIS) for benchmark standards
- Open-source security community
- Contributors and security researchers

---

**Built with 🔒 by security engineers, for security engineers**
