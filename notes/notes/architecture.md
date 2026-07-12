# Homelab Architecture

Services:
- PiHole
- Surricata
- Wazhuh (SIEM)
-- Wazuh dashboard: alerts, FIM changes, SCA results, Suricata/Pi-hole log correlation
-- "Did something bad happen?"
- Prometheus + Grafana
-- infrastructure health metrics - CPU, RAM, disk I/O, network throughput, container status, temperature
-- "is the sytem itself healthy?

Hardware:
- Unmanaged Switch
- Dell Laptop 1
-- running Wazuh
- Dell Laptop 2
-- running Surricata
-- runs as an in-line bridge configuration
- Raspberry Pi 2 Model B

-----------------


