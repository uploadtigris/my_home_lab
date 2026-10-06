# Homelab

My home network and the services on it. I use it to practice what a network
technician does on the job: segmenting networks, writing firewall policy,
running DNS and DHCP, and writing down every problem I fix so I only solve it once.

**Status means what it says:** 

![running](https://img.shields.io/badge/running-2E7D32) is live today,

![in progress](https://img.shields.io/badge/in%20progress-F9A825) is being built this month,

![planned](https://img.shields.io/badge/planned-757575) is designed but not started.

---

## Network gear

| Device | Role | Status |
|---|---|---|
| Sharevdi mini PC running pfSense | Router, firewall, DHCP; inter-VLAN routing once segmented | ![running](https://img.shields.io/badge/running-2E7D32) |
| Netgear GS308EP (8-port PoE+ smart managed switch) | 802.1Q VLANs, powers the access point | ![running](https://img.shields.io/badge/running-2E7D32) |
| TP-Link EAP610 | Wi-Fi access point (Guest SSID live today) | ![running](https://img.shields.io/badge/running-2E7D32) |
| Raspberry Pi 2 Model B | Pi-hole, DNS filtering for the whole network | ![running](https://img.shields.io/badge/running-2E7D32) |
| Dell Latitude 7490, Ubuntu LTS, 16 GB RAM | Server for NextCloud, monitoring and logging | ![planned](https://img.shields.io/badge/planned-757575) |
| APC Back-UPS 550 | Battery backup with NUT for graceful shutdown | ![planned](https://img.shields.io/badge/planned-757575) |
| TechMojo 10" rack | Holds it all | ![running](https://img.shields.io/badge/running-2E7D32) |

---

## Network design

Five VLANs, each on `10.0.<VLAN>.0/24`, so a device's VLAN shows in its IP.
![in progress](https://img.shields.io/badge/in%20progress-F9A825) (build: October 2026)

| VLAN | Name | Subnet | Who lives here |
|---|---|---|---|
| 1 | Mgmt | 10.0.1.0/24 | Switch and access point management |
| 20 | Trusted | 10.0.20.0/24 | My own laptop, phone and PCs |
| 30 | IoT | 10.0.30.0/24 | Smart devices and the hydroponics project |
| 40 | Guest | 10.0.40.0/24 | Visitors, internet only |
| 50 | Servers | 10.0.50.0/24 | Pi-hole and the Latitude server |

- pfSense routes between VLANs over one 802.1Q trunk to the switch (router-on-a-stick).
- IoT and Guest can't reach private address space; Trusted can reach everything.
- One SSID per VLAN on the EAP610 (Trusted, IoT on 2.4 GHz only, Guest with client isolation).
- Every rule gets tested from each VLAN, with the results recorded.

Full build and write-up: [network-segmentation-ids](https://github.com/uploadtigris/network-segmentation-ids)

---

## Lab domains

I organize the lab by the areas a network team actually owns.

### Network foundation

| Domain | What | Status |
|---|---|---|
| Physical layer | 10" rack, PoE budget, cabling | ![in progress](https://img.shields.io/badge/in%20progress-F9A825) |
| Segmentation | 5 VLANs on pfSense and the GS308EP | ![in progress](https://img.shields.io/badge/in%20progress-F9A825) |
| Routing and firewall | pfSense routing and firewalling the home network | ![running](https://img.shields.io/badge/running-2E7D32) |
| Firewall policy | Default deny between VLANs, documented exceptions | ![in progress](https://img.shields.io/badge/in%20progress-F9A825) |
| DNS | Pi-hole filtering DNS for every device | ![running](https://img.shields.io/badge/running-2E7D32) |
| DHCP | Per-VLAN scopes and static mappings on pfSense | ![in progress](https://img.shields.io/badge/in%20progress-F9A825) |
| Wireless | One SSID per VLAN on the EAP610 | ![in progress](https://img.shields.io/badge/in%20progress-F9A825) |
| Remote access | WireGuard VPN into the lab | ![planned](https://img.shields.io/badge/planned-757575) |

### Operations

| Domain | What | Status |
|---|---|---|
| Monitoring | LibreNMS + SNMP on the switch and firewall; Prometheus and Grafana | ![planned](https://img.shields.io/badge/planned-757575) |
| Logging and SIEM | Wazuh rebuild with pfSense syslog | ![planned](https://img.shields.io/badge/planned-757575) |
| Power | UPS + NUT, power metrics in Grafana | ![planned](https://img.shields.io/badge/planned-757575) |
| Backup and recovery | Config backups for pfSense, switch and AP; restic to a USB drive | ![planned](https://img.shields.io/badge/planned-757575) |

### Management

| Domain | What | Status |
|---|---|---|
| Documentation | IP plan, port map, diagrams, troubleshooting write-ups | ![in progress](https://img.shields.io/badge/in%20progress-F9A825) |
| Validation | Test matrix for every VLAN and firewall rule | ![in progress](https://img.shields.io/badge/in%20progress-F9A825) |
| Dashboard | Homepage dashboard linking every service | ![planned](https://img.shields.io/badge/planned-757575) |
| Automation | Bash and Python scripts, config backups as code | ![planned](https://img.shields.io/badge/planned-757575) |

### Services and projects

| Domain | What | Status |
|---|---|---|
| NextCloud | Personal cloud storage on the Servers VLAN | ![planned](https://img.shields.io/badge/planned-757575) |
| IoT / hydroponics | Pi Zero W, Pico W and sensors on the IoT VLAN | ![planned](https://img.shields.io/badge/planned-757575) |

---

## Cert path

- [x] CompTIA Security+
- [ ] CompTIA Network+ (exam October 2026)
- [ ] Cisco CCNA

---

## Related

- Troubleshooting write-ups: [sysadmin_handbook](https://github.com/uploadtigris/sysadmin_handbook)
- Study notes: [networking_notes](https://github.com/uploadtigris/networking_notes)
- Portfolio: [uploadtigris.github.io](https://uploadtigris.github.io)

*Last updated: October 2026*
