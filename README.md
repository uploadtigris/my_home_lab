# Homelab & Linux Certification Journey

> A hands-on learning environment for RHCSA/RHCE certification preparation, infrastructure automation, and cloud engineering practice.

## 🎯 Mission

This repository documents my journey toward Red Hat certification and practical infrastructure automation skills. The homelab serves as a production-like environment for learning enterprise Linux administration, Ansible automation, and hybrid cloud architectures.

## 📚 Learning Roadmap

### Current Focus: RHCSA Preparation (Weeks 1-12)

**Core Skills Development:**
- Linux system administration fundamentals
- Storage management (LVM, partitions, file systems)
- User and permission management
- Network configuration and firewall management
- SELinux implementation and troubleshooting
- Systemd service management
- Automated task scheduling

**Study Resources:**
- *The Linux Bible* by Christopher Negus
- *How Linux Works* by Brian Ward
- Red Hat Official Documentation
- Hands-on lab practice in Proxmox VMs

### Next Phase: RHCE Preparation (Weeks 13-20)

**Automation Focus:**
- Ansible fundamentals and playbook development
- Role-based automation architecture
- Template management with Jinja2
- Ansible Vault for secrets management
- Infrastructure-as-Code best practices
- Automated configuration management across multiple systems

**Practical Application:**
All homelab services will be deployed and managed via Ansible playbooks, documented in this repository.

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
- **VM1:** Ubuntu Server (Monitoring Stack - Grafana, Prometheus)
- **VM2:** AlmaLinux 9 (RHEL-compatible for RHCE practice)

#### Test Environment (Thinkpad W541)
```
Role: Learning Lab & Experimentation
Model: Thinkpad W541
CPU: Intel Core i7-4xxx (quad-core)
RAM: 32 GB DDR3
Storage: [SSD Configuration]
Hypervisor: Proxmox VE
```

**Purpose:**
- RHCSA/RHCE hands-on practice environment
- Multi-VM scenarios for Ansible automation
- Snapshot-based learning (test, break, restore)
- Cross-distribution testing

---

## 🚀 Homelab Services

### Phase 1: Core Infrastructure (In Progress)
- [x] **Pi-hole** - Network-wide ad blocking and DNS
- [ ] **pfSense** - Firewall and router
- [ ] **Dynamic DNS** - Remote access configuration
- [ ] **Nginx** - Reverse proxy and web server
- [ ] **Nginx Proxy Manager** - GUI-based proxy management

### Phase 2: Self-Hosted Applications
- [ ] **Nextcloud** - Private cloud storage
- [ ] **Plex Media Server** - Media streaming
- [ ] **Grafana + Prometheus** - Infrastructure monitoring
- [ ] **Homepage/Dashboard** - Unified service access portal

### Phase 3: Advanced Services
- [ ] **GitLab CE** - Self-hosted Git repository
- [ ] **Vault** - Secrets management
- [ ] **Portainer** - Container management
- [ ] **Uptime Kuma** - Service monitoring

### Web Portal: uploadtigris.com
A custom authentication portal with Route53 DNS routing to self-hosted services:
- User authentication system
- Custom theme support
- Service discovery dashboard
- Dynamic routing to internal services

---

## 🤖 Ansible Automation Strategy

All infrastructure will be managed as code using Ansible. The repository structure follows best practices:

```
ansible/
├── inventories/
│   ├── production/
│   └── development/
├── playbooks/
│   ├── site.yml
│   ├── proxmox-setup.yml
│   ├── pihole-deploy.yml
│   ├── monitoring-stack.yml
│   └── web-services.yml
├── roles/
│   ├── common/
│   ├── pihole/
│   ├── nginx/
│   ├── nextcloud/
│   └── monitoring/
├── group_vars/
├── host_vars/
└── ansible.cfg
```

### Automation Goals (RHCE Practice)
1. **Idempotent deployments** - Services can be safely re-run
2. **Role-based organization** - Reusable, modular components
3. **Templated configurations** - Dynamic config generation
4. **Encrypted secrets** - Ansible Vault for sensitive data
5. **Multi-environment support** - Dev/Test/Prod separation
6. **Documentation as code** - Self-documenting playbooks

---

## ☁️ AWS Integration Projects

### Build Philosophy: Manual → Terraform

Each project will be built manually first to understand the components, then automated with Infrastructure-as-Code.

### Planned Projects

#### 1. Three-Tier Web Application
**Components:**
- Web Tier: EC2 instances behind Application Load Balancer
- Application Tier: EC2/Lambda functions
- Data Tier: RDS Multi-AZ deployment
- Route 53 DNS management

**Skills Focus:** VPC design, security groups, IAM roles, load balancing

#### 2. High Availability Architecture
**Components:**
- Multi-AZ deployment across 3 availability zones
- Auto Scaling Groups with dynamic scaling policies
- RDS read replicas and automated backups
- Route 53 health checks and failover routing

**Skills Focus:** Resilience, disaster recovery, performance optimization

#### 3. Serverless Application
**Components:**
- S3 static website hosting
- CloudFront CDN distribution
- API Gateway + Lambda backend
- DynamoDB database
- Cognito authentication

**Skills Focus:** Event-driven architecture, cost optimization, managed services

#### 4. Hybrid Cloud Connection
**Components:**
- Site-to-Site VPN between homelab and AWS VPC
- VPC Peering and Transit Gateway
- Direct Connect concepts (simulated)
- AWS Systems Manager for hybrid management

**Skills Focus:** Network integration, hybrid architecture patterns

#### 5. Security & Compliance Implementation
**Components:**
- IAM roles and policies (principle of least privilege)
- CloudTrail logging and analysis
- KMS encryption for data at rest
- AWS Config rules and compliance checking
- GuardDuty threat detection
- Secrets Manager integration

**Skills Focus:** Security best practices, compliance frameworks

#### 6. Cost Optimization Strategy
**Components:**
- Cost Explorer analysis and reporting
- CloudWatch billing alarms
- S3 Intelligent Tiering and lifecycle policies
- EC2 rightsizing recommendations
- Reserved Instances and Savings Plans analysis

**Skills Focus:** FinOps, cost-aware architecture

#### 7. Infrastructure as Code
**Final Stage:** All AWS projects automated with:
- Terraform modules and state management
- CloudFormation templates
- CI/CD pipeline for infrastructure changes

---

## 📊 Progress Tracking

### RHCSA Preparation
- [ ] Week 1-2: Linux Fundamentals
- [ ] Week 3-4: File Management & Text Processing
- [ ] Week 5-6: System Administration Basics
- [ ] Week 7-8: Storage & File Systems
- [ ] Week 9-10: Networking & Services
- [ ] Week 11-12: Mock Exams & Critical Topics
- [ ] **RHCSA Exam Scheduled:** TBD

### RHCE Preparation
- [ ] Week 13-14: Ansible Fundamentals
- [ ] Week 15-16: Playbooks & Roles
- [ ] Week 17-18: Advanced Automation
- [ ] Week 19-20: Mock Exams
- [ ] **RHCE Exam Scheduled:** TBD

### Homelab Milestones
- [ ] Proxmox production server configured
- [ ] Proxmox test environment operational
- [ ] First service automated with Ansible
- [ ] All core services Ansible-managed
- [ ] Monitoring stack operational
- [ ] Web portal deployed
- [ ] AWS hybrid connection established

---

## 📖 Documentation Structure

Each service deployment includes:
- **Overview:** Purpose and architecture
- **Prerequisites:** Dependencies and requirements
- **Manual Setup Guide:** Step-by-step installation
- **Ansible Playbook:** Automated deployment
- **Configuration:** Key settings and customization
- **Troubleshooting:** Common issues and solutions
- **Maintenance:** Backup, updates, monitoring

Documentation location: `/docs/services/[service-name]/`

---

## 🛠️ Technology Stack

**Virtualization:** Proxmox VE  
**Operating Systems:** Ubuntu Server, AlmaLinux 9, Rocky Linux  
**Automation:** Ansible, Bash scripting  
**Containers:** Docker, Podman  
**Monitoring:** Grafana, Prometheus, Uptime Kuma  
**Networking:** pfSense, Pi-hole, Nginx  
**Cloud:** AWS (EC2, S3, Lambda, RDS, Route53)  
**IaC:** Terraform, CloudFormation  
**Version Control:** Git, GitHub  

---

## 🎓 Learning Resources

- Red Hat Official Documentation
- *The Linux Bible* - Christopher Negus
- *How Linux Works* - Brian Ward
- Ansible Documentation
- AWS Well-Architected Framework
- Terraform Documentation
- Community forums and r/homelab

---

## 📝 Repository Structure

```
homelab/
├── README.md                          # This file
├── docs/
│   ├── RHCSA-study-plan.md
│   ├── RHCE-study-plan.md
│   ├── services/                      # Service-specific documentation
│   └── aws/                           # AWS project documentation
├── ansible/
│   ├── inventories/
│   ├── playbooks/
│   ├── roles/
│   └── group_vars/
├── terraform/
│   ├── aws/
│   └── modules/
├── scripts/                           # Utility scripts
└── configs/                           # Configuration templates
```

---

## 🤝 Contributing

This is a personal learning repository, but suggestions and feedback are welcome! Feel free to open an issue if you spot errors or have recommendations.

---

## 📜 License

MIT License - Feel free to use this as inspiration for your own homelab journey.

---

## 🔗 Connect

**Blog/Portfolio:** uploadtigris.com  
**Progress Updates:** [Link to blog/social media]

---

*Last Updated: January 2026*  
*Current Phase: RHCSA Preparation - Week 1*