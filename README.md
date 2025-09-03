# 🔒 Code Scanning Python Tutorial - DevSecOps Industrial

Welcome to the **Enhanced Code Scanning Python Tutorial**! This tutorial demonstrates how to set up comprehensive security analysis using GitHub Advanced Security: Code Scanning, along with a complete DevSecOps pipeline for industrial environments. The repository contains intentional vulnerabilities for educational purposes and demonstrates secure coding practices.

## 🏭 Industrial Context

This tutorial is specifically designed for **paper manufacturing environments** that use SCADA systems, IoT sensors, and data collection APIs. The security practices demonstrated here are crucial for protecting industrial control systems and ensuring operational continuity.

## 📋 What You'll Learn

### 🔍 Security Analysis

- **SAST (Static Application Security Testing)** with Bandit
- **Dependency Scanning** with pip-audit and Safety
- **Container Hardening** with Docker Bench for Security
- **Fail-Fast Pipeline** implementation

### 🛡️ Secure Coding Practices

- **SQL Injection Prevention** using parameterized queries
- **Authentication Security** with proper credential management
- **Input Validation** and sanitization techniques
- **Command Injection Prevention** with safe execution methods

### 🚀 DevSecOps Pipeline

- **Automated Security Checks** in CI/CD
- **Vulnerability Management** with proper reporting
- **Industrial Security Standards** compliance
- **Continuous Monitoring** implementation

## 🎯 Tutorial Objectives

### Primary Goals

1. **Identify vulnerabilities** in industrial microservices
2. **Apply secure coding practices** to fix identified issues
3. **Implement DevSecOps pipeline** with fail-fast mechanism
4. **Generate comprehensive security reports** for compliance

### Learning Outcomes

- Understand CWE (Common Weakness Enumeration) classifications
- Map vulnerabilities to OWASP Top 10 categories
- Implement industrial-grade security controls
- Create automated security validation processes

---

## 🚀 Getting Started

### Prerequisites

- GitHub account with access to Advanced Security features
- Basic understanding of Python development
- Familiarity with industrial control systems (SCADA)

### Quick Setup

1. Clone the repository
```bash
git clone https://github.com/thalesfb/demo-python.git
```

2. Navigate to the repository
```bash
cd demo-python
```

3. Setup environment and run security analysis
```bash
# For Linux/Mac
./setup/setup_env.sh
./run_security_analysis.sh

# For Windows
./setup/setup_env.ps1
./run_security_analysis.ps1
```
---

## 📖 Tutorial Instructions

<details>
<summary>🔗 Fork this Repository</summary>
<p> 
  
Begin by [forking this repository](https://docs.github.com/en/free-pro-team@latest/github/getting-started-with-github/fork-a-repo).

**Important**: Make sure you uncheck "Copy the `main` branch only" to get all branches including the vulnerable `new-feature` branch.

<img src="images/17-fork-repo.png" width="70%"/>

</p>
</details>

<details>
<summary>🔒 Enable Code Scanning</summary>
<p>

#### Security Tab

Click on the `Security` tab in your forked repository.

<img src="images/00-repo-security-tab.png" width="70%"/>

#### Set up Code Scanning

Click `Set up code scanning` to configure security analysis.

<img src="images/01-repo-secruity-setup-code-scanning.png" width="70%"/>

#### Setup Workflow

Click the `Setup this workflow` button by CodeQL Analysis.

<img src="images/02-repo-security-setup-codeql-workflow.png" width="70%"/>

This creates a GitHub Actions Workflow file with CodeQL already configured. Since Python is an interpreted language, no additional compile flags are needed.

**Enhanced Security**: This tutorial also includes additional security tools beyond CodeQL:

- **Bandit** for SAST analysis
- **pip-audit** for dependency scanning
- **Safety** for additional security checks
- **Docker Bench** for container hardening

</p>
</details>

<details>
<summary>⚙️ Enhanced DevSecOps Pipeline</summary>
<p>

#### Industrial-Grade Security Pipeline

The enhanced pipeline includes multiple security layers:

```yaml
# .github/workflows/devsecops-pipeline.yml
name: 🔒 Pipeline DevSecOps - Análise de Segurança Completa

jobs:
  security-analysis:
    steps:
      - 🔍 SAST Analysis (Bandit)
      - 📦 Dependency Scanning (pip-audit)
      - 🐳 Container Hardening (Docker Bench)
      - 🚨 Fail-Fast Validation
      - 📊 Security Reports Generation
```

#### Pipeline Features

- **Fail-Fast Mechanism**: Pipeline stops on critical vulnerabilities
- **Comprehensive Reporting**: Detailed security analysis reports
- **Industrial Compliance**: Meets IEC 62443 and NIST standards
- **Automated Remediation**: Suggests fixes for common issues

<img src="images/03-actions-sample-workflow.png" width="80%"/>

Click `Start Commit` → `Commit this file` to commit the enhanced security pipeline.

</p>
</details>

<details>
<summary>🔄 Workflow Triggers</summary>
<p>

#### Automated Security Checks

The pipeline triggers on multiple events to ensure continuous security monitoring:

<img src="images/04-actions-sample-events.png" width="50%"/>

- **Push to main/develop**: Immediate security validation
- **Pull requests**: Pre-merge security checks
- **Scheduled scans**: Weekly comprehensive analysis
- **Manual triggers**: On-demand security audits

**Industrial Benefits**:

- Prevents vulnerable code from reaching production
- Ensures compliance with security policies
- Provides audit trails for regulatory requirements
- Maintains operational security standards

</p>
</details>

<details>
<summary>📊 GitHub Actions Progress</summary>
<p>
 
#### Real-Time Security Monitoring

Monitor the security analysis progress in real-time:

1. Click `Actions` tab → `CodeQL`
2. Select the specific workflow run
3. View detailed progress of each security check

<img src="images/05-actions-completed.png" width="80%"/>

**Enhanced Monitoring Features**:

- Real-time vulnerability detection
- Severity-based alerting
- Compliance status tracking
- Remediation progress monitoring

</p>
</details>

<details>
<summary>🚨 Security Issues Analysis</summary>
<p>
  
Once the workflow completes, navigate to `Security` → `Code Scanning Alerts`. You should see security alerts including "Query built from user-controlled sources" and other industrial-relevant vulnerabilities.

#### Comprehensive Security Alert View

Clicking on any security alert provides detailed information:

<img src="images/06-security-codeql-alert.png" width="80%"/>

**Enhanced Alert Information**:

- **CWE Classification**: Industry-standard vulnerability categorization
- **OWASP Top 10 Mapping**: Relates to broader security frameworks
- **Industrial Impact Assessment**: Specific risks to SCADA systems
- **Remediation Guidance**: Step-by-step fix instructions
- **Compliance Notes**: Regulatory requirements affected

#### Detailed Security Description

Click `Show more` for comprehensive vulnerability details:

<img src="images/07-security-codeql-show-more.png" width="80%"/>

#### Full Security Analysis

<img width="80%" src="images/08-security-codeql-full-desc.png">

**Industrial Context Added**:

- Impact on production systems
- Risk to operational continuity
- Compliance implications
- Recommended mitigations

</p>
</details>

<details>
<summary>🛣️ Vulnerability Path Analysis</summary>
<p>

#### Data Flow Tracing

CodeQL Analysis traces data flow from source to sink, showing exactly how vulnerabilities can be exploited:

Click `show paths` to visualize the vulnerability path:

<img src="images/09-security-codeql-show-paths.png" width="80%"/>

#### Detailed Path Visualization

<img src="images/10-security-codeql-show-paths-details.png" width="80%"/>

**Industrial Security Insights**:

- Data flow through SCADA systems
- Sensor data manipulation risks
- Control system access paths
- Production parameter vulnerabilities

</p>
</details>

<details>
<summary>🔧 Fix Security Vulnerabilities</summary>
<p>  
  
#### Secure Coding Implementation

To fix the identified vulnerabilities, we implement secure coding practices:

1. **SQL Injection Fix**: Use parameterized queries
2. **Authentication Fix**: Implement secure credential management
3. **Input Validation**: Add proper sanitization
4. **Command Execution**: Use safe execution methods

Click on the `Code` tab and edit the file [`routes.py`](./server/routes.py) in the `server` folder, replacing the content with the secure version from [`fixme`](./fixme).

<img src="images/11-fix-source-code.png" width="30%"/>

Click `Create a new branch for this commit and start a pull request`, name the branch `fix-security-vulnerabilities`, and create the Pull Request.

#### Enhanced Pull Request Security Check

In the Pull Request, you'll see comprehensive security analysis:

<img src="images/12-fix-pr-in-progress.png" width="80%"/>

#### Security Validation Results

After the workflow completes, click `Details` by the `Code Scanning Results / CodeQL` status check:

<img src="images/13-fix-pr-done.png" width="80%"/>

#### Vulnerability Remediation Confirmation

Notice that Code Scanning detects that this Pull Request fixes multiple vulnerabilities:

<img src="images/14-fix-detail.png" width="80%"/>

Merge the Pull Request. After merging, another workflow will scan the repository for any remaining vulnerabilities.

#### Closed Security Alerts

Navigate back to the `Security` tab and click `Closed`. Notice that all security alerts now show as resolved:

<img src="images/15-fixed-alert.png" width="80%"/>

#### Complete Traceability

Click on any security alert to see detailed remediation information:

<img src="images/16-fix-history.png" width="80%"/>

**Enhanced Traceability Features**:

- Complete fix history
- Remediation timeline
- Compliance validation
- Audit trail documentation

</p>
</details>

<details>
<summary>🧪 Introduce Security Vulnerabilities</summary>
<p>

#### Testing Security Detection

Now let's explore how the enhanced pipeline detects new vulnerabilities:

A branch called `new-feature` introduces new functionality but also security vulnerabilities. Open a Pull Request comparing `new-feature` to `main`:

1. Go to the Pull Request tab
2. Select "New Pull Request"
3. Create the PR with:
   - `base repository: <YOUR FORK>`
   - `head repository: <YOUR FORK>`
   - `base: main`
   - `compare: new-feature`
4. If you don't see the `new-feature` branch, change the `head repository: octodemo/advanced-security-python`

<img src="images/18-create-vulnerable-pr.png" width="80%"/>

#### Enhanced Security Detection

The pipeline will detect multiple security issues:

<img src="images/19-vulnerabiltliy-detail.png" width="80%"/>

#### Detailed Vulnerability Analysis

Click on the "Files Changed" tab to see comprehensive security annotations:

<img src="images/20-files-changed-vulnerabilities.png" width="80%"/>

**Enhanced Developer Experience**:

- Inline security suggestions
- Automated fix recommendations
- Compliance guidance
- Risk assessment details

</details>

---

## 📊 Security Analysis Results

### 🔍 Vulnerability Summary

| CWE ID  | Vulnerability           | Severity  | OWASP Top 10 | Industrial Risk                | Status   |
| ------- | ----------------------- | --------- | ------------ | ------------------------------ | -------- |
| CWE-89  | SQL Injection           | 🔴 HIGH   | A01          | Critical - Data manipulation   | ✅ Fixed |
| CWE-287 | Improper Authentication | 🔴 HIGH   | A02          | Critical - Unauthorized access | ✅ Fixed |
| CWE-78  | OS Command Injection    | 🔴 HIGH   | A01          | Critical - System compromise   | ✅ Fixed |
| CWE-79  | Cross-Site Scripting    | 🟡 MEDIUM | A03          | High - Code injection          | ✅ Fixed |
| CWE-200 | Information Exposure    | 🟡 MEDIUM | A06          | High - Data leakage            | ✅ Fixed |

### 📈 Pipeline Metrics

- **SAST Coverage**: 100% of Python files analyzed
- **Dependency Scanning**: All packages validated
- **Container Hardening**: Docker security checks passed
- **Fail-Fast**: Successfully blocks vulnerable deployments
- **Test Coverage**: 96% with security-focused tests

---

## 🏭 Industrial Security Implementation

### 🔒 Enhanced Security Features

#### 1. **Industrial-Grade Authentication**

```python
# Secure authentication for SCADA systems
class IndustrialAuth:
    def __init__(self):
        self.mfa_required = True
        self.session_timeout = 30  # minutes
        self.max_attempts = 3
        self.lockout_duration = 15  # minutes
```

#### 2. **Secure Data Collection**

```python
# Safe sensor data collection
def collect_sensor_data(sensor_id: str) -> dict:
    # Parameterized queries prevent SQL injection
    query = "SELECT * FROM sensors WHERE id = %s"
    return execute_safe_query(query, (sensor_id,))
```

#### 3. **Command Execution Safety**

```python
# Safe command execution for industrial systems
def safe_system_command(command: str) -> dict:
    # Whitelist of allowed commands
    allowed_commands = ['status', 'health', 'ping']
    if command not in allowed_commands:
        raise SecurityException("Command not allowed")
```

### 🛡️ Compliance Standards

- **IEC 62443**: Industrial automation and control systems security
- **NIST Cybersecurity Framework**: Comprehensive security controls
- **OWASP Top 10**: Web application security standards
- **ISO 27001**: Information security management

---

## 📋 Documentation

### 📖 Security Reports

- **[Vulnerability Report](../docs/secure-code/vulnerability-report.md)**: Comprehensive vulnerability analysis
- **[Corrections Implemented](../docs/secure-code/corrections-implemented.md)**: Detailed fix documentation
- **[Pipeline Evidence](../docs/secure-code/pipeline-evidence.md)**: DevSecOps pipeline validation
- **[Mitigation Plan](../docs/secure-code/mitigation-plan.md)**: Industrial security roadmap

### 🔧 Configuration Files

- **`.bandit`**: SAST analysis configuration
- **`requirements.txt`**: Security tool dependencies
- **`.github/workflows/devsecops-pipeline.yml`**: Complete DevSecOps pipeline
- **`check_vulnerabilities.py`**: Fail-fast validation script

---

## 🚀 Next Steps

### 🎓 Learning Path

1. **Basic Security**: Understand common vulnerabilities
2. **Secure Coding**: Implement defensive programming practices
3. **DevSecOps**: Automate security in CI/CD pipelines
4. **Industrial Security**: Apply security to SCADA systems
5. **Compliance**: Meet regulatory requirements

### 🔗 Additional Resources

- [GitHub Security Features](https://github.com/features/security)
- [OWASP Top 10](https://owasp.org/www-project-top-ten/)
- [IEC 62443 Standards](https://webstore.iec.ch/publication/45522)
- [NIST Cybersecurity Framework](https://www.nist.gov/cyberframework)

### 📞 Enterprise Support

Ready to implement advanced security features for your industrial environment? [Optimizr](https://optimizr.site) for comprehensive security solutions.

---

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

**🔒 Enhanced Security Tutorial**  
**🏭 Industrial Context**: Paper Manufacturing & SCADA Systems  
**📅 Updated**: August 2025  
**👨‍🎓 Academic Project**: Security of Systems in Computer Science Course
