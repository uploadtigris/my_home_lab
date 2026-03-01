# Homelab Infrastructure
Personal lab environment for hands-on learning in network security, 
systems programming, and infrastructure.

---

# Learning Roadmap

## Current Focus
- [ ] Red Hat Certified Systems Administrator (RHCSA)

## Up Next
- [ ] *C Programming: A Modern Approach* — K.N. King
- [ ] *The Linux Programming Interface* — Michael Kerrisk
- [ ] CCNA
- [ ] Integrate a SIEM (Wazuh)

---

# Hardware

**Primary Server (Desktop)**
- Ryzen 5 3600, 16GB RAM
- 2x 2TB HDD (RAID 1)
- Proxmox VE hypervisor

**Test Server (Thinkpad W541)**
- Intel i7, 32GB RAM
- Proxmox VE hypervisor
- Used for security testing and experimentation

---

## Current Services
- Pi-hole (DNS filtering)
- pfSense (planned — firewall/VPN)
- Wazuh (planned — SIEM and security monitoring)

---

## Planned Projects

**Network Security:**
- Network packet capture and analysis tool (C + libpcap)
- Threat detection agent for Linux hosts
- SIEM/log analysis setup with Wazuh
- Network security monitoring with Suricata + Zeek

**Systems Programming:**
- Linux process monitor in C
- File integrity monitor in C
- Port scanner (C then rewritten in Go)

**Infrastructure:**
- pfSense firewall with IDS/IPS rules
- Incident response environment
- Infrastructure-as-Code with Terraform

---

## Technology Stack

**Virtualization:** Proxmox VE  
**OS:** AlmaLinux, Ubuntu Server, CachyOS  
**Languages:** C (learning), Python, Bash  
**Security:** pfSense, Suricata, Zeek, Wazuh (planned)  
**IaC:** Terraform (planned)  
**Monitoring:** Grafana, Prometheus (planned)  

---

*Last Updated: March 2026*
