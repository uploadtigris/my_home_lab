# Homelab

Personal infrastructure for learning, certification prep, and systems experimentation.

---

## Hardware

| Host | Specs | Role |
|---|---|---|
| Primary Server | Ryzen 5 3600 · 16GB RAM · 2×2TB RAID 1 | Proxmox VE hypervisor |
| ThinkPad W541 | Intel i7 · 32GB RAM · AlmaLinux | Security testing and experimentation |

---

## Stack

`Proxmox` `AlmaLinux` `CachyOS` `Python` `Bash` `Go` `Ansible` `pfSense` `Wazuh` `Suricata` `Zeek`

---

## VM Infrastructure

All VMs run AlmaLinux (minimal) unless noted. Local-lvm (NVMe, ~465 GB) for VM storage.\
ZFS pool at `/mnt/zfsdata` on Proxmox host — accessed by VM 6 over NFS.

| VM | Services | vCPUs | RAM | Disk | Notes |
|---|---|---|---|---|---|
| VM 1 | NGINX · Reverse Proxy · Wazuh Agent | 2 | 2 GB | 20 GB | TLS termination; proxies Nextcloud traffic |
| VM 2 | PostgreSQL · Wazuh Agent | 2 | 8 GB | 50 GB | Internal only; `shared_buffers=2GB` |
| VM 3 | Wazuh Manager | 2 | 8 GB | 150 GB | Ports 1514/1515 open to agents; 60-day log retention |
| VM 4 | Prometheus · Grafana · Wazuh Agent | 2 | 6 GB | 80 GB | TSDB retention 30 days |
| VM 5 | Nextcloud · Wazuh Agent | 2 | 4 GB | 50 GB | App/config only; user data on NFS |
| VM 6 | Linux Mint (Personal Files) | 2 | 4 GB | 30 GB | Cinnamon desktop; NFS mount from ZFS pool |

**Totals:** 12 vCPUs · 30 GB RAM (2 GB reserved for host) · 380 GB NVMe used / 465 GB available

---

## Networking

- All VMs on `vmbr0` with static IPs
- VM 1 is the only public-facing entry point (reverse proxy)
- VM 2 (PostgreSQL) is internal only — no public exposure
- NFS share: Proxmox host (`192.168.1.2`) exports `/mnt/zfsdata/photos` to `192.168.1.0/24`

---

## Services

| Service | Purpose | Status |
|---|---|---|
| Pi-hole | DNS filtering | Running |
| Wazuh | SIEM | Running |
| NGINX | Reverse proxy + web server | Running |
| PostgreSQL | Database | Running |
| Prometheus / Grafana | Metrics and dashboards | Running |
| Nextcloud | Personal cloud storage | Running |
| pfSense | Firewall / VPN | Planned |

---

## Cert Path

- [X] Security+
- [ ] RHCSA
- [ ] AWS SysOps Administrator
- [ ] AWS Security Specialist

---

## Projects

- Bash and Python automation for system administration
- Log analysis and monitoring tooling
- pfSense firewall setup with IDS/IPS rules
- Suricata + Zeek network monitoring
- Ansible playbooks for configuration management

---

## Learning
- [RHCSA Roadmap](https://github.com/uploadtigris/my_home_lab/blob/main/notes/rhcsa/rhcsa_study_roadmap.md)
- [RHCSA Exam Objectives](https://github.com/uploadtigris/my_home_lab/blob/main/notes/rhcsa/Exam_Objectives.md)

*Last updated: March 2026*
