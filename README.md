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

<p align="center">
  <img src="images/homelab.png" alt="Homelab network diagram" width="400">
</p>

| Device | Role | Status |
|---|---|---|
| Sharevdi mini PC running pfSense | Router, firewall, DHCP; inter-VLAN routing and least-privilege rules between five VLANs | ![running](https://img.shields.io/badge/running-2E7D32) |
| Netgear GS308EP (8-port PoE+ smart managed switch) | 802.1Q VLANs, powers the access point | ![running](https://img.shields.io/badge/running-2E7D32) |
| TP-Link EAP610 | Wi-Fi access point, one SSID per VLAN (Home, IoT, Guest) | ![running](https://img.shields.io/badge/running-2E7D32) |
| Raspberry Pi 2 Model B | Pi-hole, DNS filtering, on the Servers VLAN | ![running](https://img.shields.io/badge/running-2E7D32) |
| Dell Latitude 7490, Ubuntu LTS, 16 GB RAM | Server for NextCloud, monitoring and logging | ![planned](https://img.shields.io/badge/planned-757575) |
| APC Back-UPS 550 | Battery backup with NUT for graceful shutdown | ![planned](https://img.shields.io/badge/planned-757575) |
| TechMojo 10" rack | Holds it all | ![running](https://img.shields.io/badge/running-2E7D32) |

---

## Network design

Five VLANs, each on `10.0.<VLAN>.0/24`, so a device's VLAN shows in its IP.
![running](https://img.shields.io/badge/running-2E7D32) (phase 1 completed October 2026)

| VLAN | Name | Subnet | Who lives here |
|---|---|---|---|
| 1 | Mgmt | 10.0.1.0/24 | Switch, access point and firewall admin pages; the wired recovery port |
| 20 | Trusted | 10.0.20.0/24 | My own laptop, phone and PCs |
| 30 | IoT | 10.0.30.0/24 | Smart devices and the hydroponics project |
| 40 | Guest | 10.0.40.0/24 | Visitors and work laptops, internet only |
| 50 | Servers | 10.0.50.0/24 | Pi-hole (the Latitude server moves here once NextCloud is set up) |

- pfSense routes between VLANs over one 802.1Q trunk to the switch (router-on-a-stick).
- Every VLAN allows what it needs, blocks the firewall and all internal networks, then allows the internet. Admin pages are reachable only from the wired Mgmt port.
- Trusted and IoT must use Pi-hole for DNS. Guest uses its own pfSense gateway.
- One SSID per VLAN on the EAP610 (Home, IoT on 2.4 GHz only, Guest on 5 GHz with client isolation).
- Every rule gets tested from each VLAN, with the results recorded.

Full build and write-up: [network-segmentation-ids](https://github.com/uploadtigris/network-segmentation-ids)

---

## Projects

Each project has its own repo with the same layout: a `README.md` for the design,
`docs/` for the build notes, and `images/` for screenshots.

| Project | What it is | Status | README | Build |
|---|---|---|---|---|
| [network-segmentation-ids](https://github.com/uploadtigris/network-segmentation-ids) | Five VLANs on pfSense, a managed switch and a multi-SSID access point | ![running](https://img.shields.io/badge/running-2E7D32) | [README](https://github.com/uploadtigris/network-segmentation-ids/blob/main/README.md) | [Build log](https://github.com/uploadtigris/network-segmentation-ids/blob/main/docs/build-log.md) |
| [piHole_network_DNS](https://github.com/uploadtigris/piHole_network_DNS) | Pi-hole as the DNS server for the whole network | ![running](https://img.shields.io/badge/running-2E7D32) | [README](https://github.com/uploadtigris/piHole_network_DNS/blob/main/README.md) | [Setup guide](https://github.com/uploadtigris/piHole_network_DNS/blob/main/docs/01_setup-guide.md) |
| [wazuh-siem-homelab](https://github.com/uploadtigris/wazuh-siem-homelab) | Self-hosted Wazuh SIEM; first build retired, rebuild planned | ![planned](https://img.shields.io/badge/planned-757575) | [README](https://github.com/uploadtigris/wazuh-siem-homelab/blob/main/README.md) | [Build log](https://github.com/uploadtigris/wazuh-siem-homelab/blob/main/docs/build-log.md) |

---

## Lab domains

I organize the lab by the areas a network team actually owns.

### Network foundation

| Domain | What | Status |
|---|---|---|
| Physical layer | 10" rack, PoE budget, cabling | ![in progress](https://img.shields.io/badge/in%20progress-F9A825) |
| Segmentation | 5 VLANs on pfSense and the GS308EP | ![running](https://img.shields.io/badge/running-2E7D32) |
| Routing and firewall | pfSense routing and firewalling the home network | ![running](https://img.shields.io/badge/running-2E7D32) |
| Firewall policy | Least-privilege rules on every VLAN, documented exceptions | ![running](https://img.shields.io/badge/running-2E7D32) |
| DNS | Pi-hole filtering DNS for every device | ![running](https://img.shields.io/badge/running-2E7D32) |
| DHCP | Per-VLAN scopes and static mappings on pfSense | ![running](https://img.shields.io/badge/running-2E7D32) |
| Wireless | One SSID per VLAN on the EAP610 | ![running](https://img.shields.io/badge/running-2E7D32) |
| Remote access | WireGuard VPN into the lab | ![planned](https://img.shields.io/badge/planned-757575) |

### Operations

| Domain | What | Status |
|---|---|---|
| Monitoring | LibreNMS + SNMP on the switch and firewall | ![planned](https://img.shields.io/badge/planned-757575) |
| Logging and SIEM | Wazuh rebuild with pfSense syslog | ![planned](https://img.shields.io/badge/planned-757575) |
| Power | UPS + NUT for graceful shutdown | ![planned](https://img.shields.io/badge/planned-757575) |
| Backup and recovery | Config backups for pfSense, switch and AP; restic to a USB drive | ![planned](https://img.shields.io/badge/planned-757575) |

### Management

| Domain | What | Status |
|---|---|---|
| Documentation | IP plan, port map, diagrams, troubleshooting write-ups | ![in progress](https://img.shields.io/badge/in%20progress-F9A825) |
| Validation | Test matrix for every VLAN and firewall rule | ![running](https://img.shields.io/badge/running-2E7D32) |
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
- [ ] Cisco CCNA

---

## Related

- Study notes: [networking_notes](https://github.com/uploadtigris/networking_notes)
- Portfolio: [uploadtigris.github.io](https://uploadtigris.github.io)

*Last updated: October 2026*
