# Homelab & Cloud Certification Journey

> A hands-on learning environment for Security+, Azure administration, and Infrastructure-as-Code with Terraform. Building practical cybersecurity and cloud engineering skills through real-world implementations.

## 🎯 Mission

This repository documents my journey toward industry-recognized certifications in cybersecurity and cloud infrastructure. The homelab serves as a production-like environment for learning security fundamentals, Azure cloud administration, and infrastructure automation with Terraform.

## 📚 Learning Roadmap

### Phase 1: Security+ Certification (Weeks 1-8)

**Core Competencies:**
- **Threats, Attacks & Vulnerabilities:** Attack types, threat actors, vulnerability assessment
- **Architecture & Design:** Security architecture, secure network design, cloud security
- **Implementation:** Secure protocols, identity management, PKI, cryptography
- **Operations & Incident Response:** Security tools, incident response, digital forensics
- **Governance, Risk & Compliance:** Policies, frameworks, risk management, compliance

**Study Resources:**
- Professor Messer's Security+ Course
- CompTIA Security+ Official Study Guide
- TryHackMe / HackTheBox practice labs
- Hands-on security implementations in homelab

**Homelab Security Projects:**
- Pi-hole with security-focused DNS filtering
- pfSense firewall with IDS/IPS configuration
- VPN implementation for secure remote access
- SSL/TLS certificate management
- Security monitoring and log analysis

### Phase 2: Azure Administrator (AZ-104) (Weeks 9-16)

**Azure Core Skills:**
- **Identity & Governance:** Azure AD, RBAC, Azure Policy, subscriptions
- **Storage:** Storage accounts, blob storage, file shares, backup solutions
- **Compute:** Virtual machines, containers, Azure App Service
- **Networking:** VNets, NSGs, load balancers, VPN Gateway, Azure DNS
- **Monitoring:** Azure Monitor, Log Analytics, Application Insights

**Study Resources:**
- Microsoft Learn AZ-104 Learning Path
- Azure Documentation and Quickstarts
- Azure Sandbox environments
- John Savill's Azure Master Class
- Hands-on Azure deployments

**Homelab-to-Cloud Integration:**
- Hybrid connectivity (Site-to-Site VPN)
- Azure backup for on-premises resources
- Azure monitoring for homelab services
- Cost-optimized cloud resource deployment

### Phase 3: HashiCorp Terraform Associate (Weeks 17-24)

**Infrastructure-as-Code Mastery:**
- Terraform fundamentals and HCL syntax
- State management and backends
- Modules and reusable components
- Multi-cloud deployments (Azure primary)
- Terraform Cloud/Enterprise workflows
- Security and secrets management

**Practical Application:**
- All Azure infrastructure deployed via Terraform
- Modular, reusable code architecture
- CI/CD integration with GitHub Actions
- State management with Azure Storage
- Documentation-as-code practices

---

## 🏗️ Infrastructure Architecture

### Hardware Inventory

#### Production Server (Desktop)
```
Role: Primary Services Host
Model: Custom Built PC
CPU: Ryzen 5 3600 
RAM: 16 GB DDR4
GPU: AMD Radeon RX 580
Storage: 2x 2TB HDD (RAID 1 Mirror)
Hypervisor: Proxmox VE
```

**Virtual Machines:**
- **VM1:** Ubuntu Server (Security monitoring - Wazuh/OSSEC, Pi-hole)
- **VM2:** pfSense (Firewall, VPN, IDS/IPS)
- **VM3:** Ubuntu Server (Web services, reverse proxy)

#### Test Environment (Thinkpad W541)
```
Role: Learning Lab & Security Testing
Model: Thinkpad W541
CPU: Intel Core i7-4xxx (quad-core)
RAM: 32 GB DDR3
Storage: [SSD Configuration]
Hypervisor: Proxmox VE
```

**Purpose:**
- Security testing and vulnerability assessment
- Azure hybrid cloud testing
- Terraform deployment validation
- Snapshot-based experimentation

---

## 🚀 Homelab Services

### Phase 1: Security Foundation (In Progress)
- [x] **Pi-hole** - DNS-level ad blocking and security filtering
- [ ] **pfSense** - Enterprise firewall with IDS/IPS (Suricata/Snort)
- [ ] **OpenVPN/WireGuard** - Secure remote access VPN
- [ ] **Nginx** - Reverse proxy with SSL/TLS termination
- [ ] **Fail2Ban** - Intrusion prevention system

### Phase 2: Security Monitoring & Compliance
- [ ] **Wazuh** - Security monitoring and SIEM
- [ ] **Graylog/ELK Stack** - Centralized log management
- [ ] **Uptime Kuma** - Service availability monitoring
- [ ] **Vault** - Secrets management (learning HashiCorp ecosystem)
- [ ] **Certificate Authority** - Internal PKI infrastructure

### Phase 3: Cloud-Integrated Services
- [ ] **Azure Backup** - Hybrid backup solution
- [ ] **Azure Monitor Agent** - Cloud-based monitoring
- [ ] **Azure File Sync** - Hybrid file services
- [ ] **Azure Arc** - Hybrid server management
- [ ] **Nextcloud** - Self-hosted cloud storage with Azure backup

### Phase 4: Production Applications
- [ ] **GitLab CE** - Self-hosted Git with CI/CD
- [ ] **Portainer** - Container management
- [ ] **Grafana + Prometheus** - Infrastructure visualization
- [ ] **Homepage Dashboard** - Unified service portal

### Web Portal: uploadtigris.com
Authentication portal with Azure AD integration and Terraform-managed DNS:
- Azure AD SSO integration
- Route53/Azure DNS managed via Terraform
- Custom authentication with security hardening
- Service discovery dashboard
- SSL/TLS with automated certificate renewal

---

## ☁️ Azure Cloud Architecture

All Azure resources will be deployed and managed using Terraform:

```
terraform/
├── environments/
│   ├── dev/
│   ├── staging/
│   └── production/
├── modules/
│   ├── networking/
│   ├── compute/
│   ├── storage/
│   ├── security/
│   └── monitoring/
├── main.tf
├── variables.tf
├── outputs.tf
└── terraform.tfvars.example
```

### Azure Services Implementation
1. **Hybrid Connectivity** - VPN Gateway connecting homelab to Azure VNet
2. **Backup & DR** - Azure Backup for critical homelab data
3. **Monitoring** - Azure Monitor for hybrid infrastructure visibility
4. **Identity** - Azure AD for unified authentication
5. **Cost Management** - Budget alerts and resource optimization
6. **Security** - Azure Security Center, Key Vault, NSGs

---

## 🔒 Security Implementation Focus

### Network Security
- Segmented VLANs for service isolation
- pfSense firewall rules with least-privilege access
- IDS/IPS with Suricata for threat detection
- VPN-only access for management interfaces
- Geographic IP blocking for public services

### Identity & Access Management
- Azure AD integration for centralized identity
- Multi-factor authentication (MFA) enforcement
- Role-based access control (RBAC)
- Privileged Identity Management (PIM)
- Regular access reviews and audits

### Data Protection
- Encryption at rest for all storage
- TLS 1.3 for all network communication
- Azure Backup for critical data
- Immutable backups for ransomware protection
- Regular backup testing and restoration drills

### Compliance & Monitoring
- Centralized logging with Wazuh/Graylog
- Security incident response procedures
- Vulnerability scanning and patch management
- Compliance reporting (CIS benchmarks)
- Regular security audits and assessments

---

## 📊 Progress Tracking

### Security+ Certification
- [ ] Week 1-2: Threats, Attacks & Vulnerabilities
- [ ] Week 3-4: Architecture & Design
- [ ] Week 5-6: Implementation (Cryptography, PKI, IAM)
- [ ] Week 7: Operations & Incident Response
- [ ] Week 8: Governance, Risk & Compliance + Practice Exams
- [ ] **Security+ Exam Scheduled:** TBD

### AZ-104 Azure Administrator
- [ ] Week 9-10: Azure Identity & Governance
- [ ] Week 11-12: Storage & Virtual Machines
- [ ] Week 13-14: Networking & Security
- [ ] Week 15: Monitoring & Backup
- [ ] Week 16: Practice Labs & Mock Exams
- [ ] **AZ-104 Exam Scheduled:** TBD

### Terraform Associate Certification
- [ ] Week 17-18: Terraform Fundamentals
- [ ] Week 19-20: State Management & Modules
- [ ] Week 21-22: Advanced Terraform & Multi-Cloud
- [ ] Week 23: Terraform Cloud & Enterprise
- [ ] Week 24: Practice Exams & Real-World Scenarios
- [ ] **Terraform Exam Scheduled:** TBD

### Homelab Milestones
- [ ] Security baseline established (pfSense, VPN, monitoring)
- [ ] All services behind reverse proxy with SSL/TLS
- [ ] Azure hybrid connectivity operational
- [ ] First Azure resource deployed via Terraform
- [ ] All Azure infrastructure fully Terraform-managed
- [ ] Security monitoring dashboard operational
- [ ] Automated backup and DR tested

---

## 📖 Documentation Structure

Each implementation includes:
- **Security Considerations:** Threat model and security controls
- **Architecture Diagram:** Network topology and data flows
- **Manual Setup Guide:** Step-by-step implementation
- **Terraform Code:** Infrastructure-as-Code deployment
- **Configuration:** Security hardening and best practices
- **Monitoring:** Security logging and alerting
- **Incident Response:** Troubleshooting and recovery procedures

Documentation location: `/docs/[category]/[service-name]/`

---

## 🛠️ Technology Stack

**Virtualization:** Proxmox VE  
**Operating Systems:** Ubuntu Server, pfSense  
**Security:** Wazuh, Suricata/Snort, Fail2Ban, OpenVPN/WireGuard  
**Cloud Platform:** Microsoft Azure (VMs, VNets, Storage, Backup, Monitor)  
**Infrastructure-as-Code:** Terraform, Azure Resource Manager  
**Containers:** Docker, Podman  
**Monitoring:** Grafana, Prometheus, Azure Monitor, Wazuh  
**Networking:** pfSense, Nginx, Azure VPN Gateway  
**Identity:** Azure Active Directory  
**Version Control:** Git, GitHub  
**CI/CD:** GitHub Actions, Azure DevOps  

---

## 🎓 Learning Resources

**Security+:**
- CompTIA Security+ Official Study Guide (SY0-701)
- Professor Messer's Security+ Training Course
- TryHackMe Security+ Learning Path
- Practice exams (Dion Training, Messer)

**AZ-104:**
- Microsoft Learn AZ-104 Learning Path
- John Savill's Azure Master Class (YouTube)
- Azure Documentation and Quickstarts
- Whizlabs/MeasureUp practice exams

**Terraform:**
- HashiCorp Terraform Tutorials
- Terraform: Up & Running (O'Reilly)
- Terraform Associate Certification Guide
- Azure Terraform Documentation

**General:**
- Azure Well-Architected Framework
- CIS Benchmarks for security hardening
- NIST Cybersecurity Framework
- Community forums (r/homelab, r/CompTIA, r/Azure)

---

## 📝 Repository Structure

```
homelab/
├── README.md                          # This file
├── docs/
│   ├── certifications/
│   │   ├── security-plus-study-plan.md
│   │   ├── az-104-study-plan.md
│   │   └── terraform-study-plan.md
│   ├── security/                      # Security documentation
│   ├── azure/                         # Azure architecture docs
│   └── services/                      # Service-specific guides
├── terraform/
│   ├── azure/
│   │   ├── environments/
│   │   ├── modules/
│   │   └── README.md
│   └── homelab/                       # Terraform for local resources
├── configs/                           # Configuration templates
│   ├── pfsense/
│   ├── nginx/
│   └── security/
├── scripts/                           # Automation scripts
│   ├── backup/
│   ├── monitoring/
│   └── security/
└── diagrams/                          # Architecture diagrams
    ├── network-topology.png
    └── azure-architecture.png
```

---

## 🤝 Contributing

This is a personal learning repository, but suggestions and feedback are welcome! Feel free to open an issue if you spot errors or have recommendations for security improvements or cloud architecture.

---

## 📜 License

MIT License - Feel free to use this as inspiration for your own homelab and certification journey.

---

## 🔗 Connect

**Blog/Portfolio:** [uploadtigris.github.io](https://uploadtigris.github.io/)  
**LinkedIn:** [Your LinkedIn Profile]  
**Progress Updates:** [Link to blog/social media]

---

*Last Updated: February 2026*  
*Current Phase: Security+ Preparation - Week 1*  
*Next Milestone: Security+ Certification*