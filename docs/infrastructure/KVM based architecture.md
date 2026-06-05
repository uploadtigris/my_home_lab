# Homelab Service Architecture

---

## 🖥️ **Host Machine (KVM on Fedora)**

### **VMs**

```
+---------------------------------------------------+
|                    HOST (KVM)                     |
|                                                   |
|  +---------------+  +---------------+            |
|  |  NGINX VM     |  |  MySQL VM     |            |
|  | - Debian      |  | - Debian      |            |
|  | - NGINX       |  | - MySQL       |            |
|  | - Dashboard   |  | - Wazuh Agent |            |
|  | - Wazuh Agent |  |               |            |
|  +---------------+  +---------------+            |
|                                                   |
|  +---------------+  +---------------+            |
|  | Grafana VM    |  | Wazuh VM      |            |
|  | - Debian      |  | - Debian      |            |
|  | - Grafana     |  | - Wazuh       |            |
|  | - Prometheus  |  | - Wazuh Agent |            |
|  | - Wazuh Agent |  |               |            |
|  +---------------+  +---------------+            |
+---------------------------------------------------+
```

---

### **Decentralized Services**

```
+---------------------------------------------------+
|              DECENTRALIZED SERVICES                |
|                                                   |
|  +---------------+  +---------------+            |
|  | Hydroponics Pi |  | Pi-hole Pi     |            |
|  | - Raspberry Pi OS Lite |  | - Raspberry Pi OS Lite |  |
|  | - Node Exporter|  | - Pi-hole      |            |
|  | - Wazuh Agent  |  | - Wazuh Agent  |            |
|  +---------------+  +---------------+            |
|                                                   |
|  +---------------+  +---------------+            |
|  | Security Sys   |  | Calendar       |            |
|  | - Raspberry Pi OS Lite |  | - N/A          |            |
|  | - Node Exporter|  | - API/CalDAV    |            |
|  | - Wazuh Agent  |  |               |            |
|  +---------------+  +---------------+            |
+---------------------------------------------------+
```