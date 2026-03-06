# Proxmox VE Setup

## Installation

1. Download Proxmox VE ISO
2. Boot from USB
3. Follow installation wizard
4. Set IP address and hostname

## Initial Configuration

Web interface: https://proxmox-ip:8006

1. Update repositories
2. Update system
3. Create VM templates
4. Configure storage
5. Set up backup schedule

## VM Creation

1. Upload ISO to local storage
2. Create VM from ISO
3. Configure resources (CPU, RAM, disk)
4. Install OS
5. Convert to template (optional)

## Create an admin user

users > add > enter user name:, realm: linux PAM standard authentication, enabled
clicked on "permissions" > add > user permission > path: \ > select user > role: administrator
bash
- useradd -m username
- passwd username

[Alma Linux OS CIS Benchmark](https://www.cisecurity.org/benchmark/almalinuxos_linux)

## VM 1
- NGNIX
- Wazuh agent
- Reverse Proxy 
### VM 1 Setup
#### NGINX

**1. Update your system first:**

bash

```bash
sudo dnf update -y
```

**2. Install Nginx:**

bash

```bash
sudo dnf install nginx -y
```

**3. Start and enable Nginx (so it starts on boot):**

bash

```bash
sudo systemctl start nginx
sudo systemctl enable nginx
```

**4. Verify it's running:**

bash

```bash
sudo systemctl status nginx
```

**5. Allow HTTP/HTTPS through the firewall:**

bash

```bash
sudo firewall-cmd --permanent --add-service=http
sudo firewall-cmd --permanent --add-service=https
sudo firewall-cmd --reload
```

**6. Confirm Nginx is serving traffic:**

bash

```bash
curl http://localhost
```

Show the IPv4 address

```bash
ip a show enp6s18 | grep "inet "
```

enter into browser to view the default webpage

## VM 2
- Database
- PostgreSQL
- Wazuh agent
### VM 2 Setup

#### PostgreSQL

**1. Install PostgreSQL:**

bash

```bash
sudo dnf install postgresql-server postgresql -y
```

**2. Initialize the database:**

bash

```bash
sudo postgresql-setup --initdb
```

**3. Start and enable PostgreSQL:**

bash

```bash
sudo systemctl start postgresql
sudo systemctl enable postgresql
```

**4. Verify it's running:**

bash

```bash
sudo systemctl status postgresql
```

---

**5. Log in to PostgreSQL:**

bash

```bash
sudo -u postgres psql
```

**6. Set a password for the postgres user:**

sql

```sql
ALTER USER postgres WITH PASSWORD 'yourpassword';
\q
```

---

**Firewall (if remote access needed):**

bash

```bash
sudo firewall-cmd --permanent --add-service=postgresql
sudo firewall-cmd --reload
```

**Allow remote connections** by editing:

bash

```bash
sudo nano /etc/postgresql/data/pg_hba.conf
```

Change `ident` to `md5` for local connections, then restart:

bash

```bash
sudo systemctl restart postgresql
```

---

**Useful psql commands:**

| Command     | Description           |
| ----------- | --------------------- |
| `\l`        | List databases        |
| `\du`       | List users            |
| `\c dbname` | Connect to a database |
| `\dt`       | List tables           |
| `\q`        | Quit                  |
## VM 3
- Wazuh client
### VM 3 Setup

#### Wazuh

**1. Add the Wazuh repository:**

bash

```bash
sudo rpm --import https://packages.wazuh.com/key/GPG-KEY-WAZUH

sudo tee /etc/yum.repos.d/wazuh.repo << EOF
[wazuh]
gpgcheck=1
gpgkey=https://packages.wazuh.com/key/GPG-KEY-WAZUH
enabled=1
name=EL-\$releasever - Wazuh
baseurl=https://packages.wazuh.com/4.x/yum/
protect=1
EOF
```

**2. Install Wazuh manager:**

bash

```bash
sudo dnf install wazuh-manager -y
```

**3. Start and enable Wazuh:**

bash

```bash
sudo systemctl start wazuh-manager
sudo systemctl enable wazuh-manager
```

**4. Verify it's running:**

bash

```bash
sudo systemctl status wazuh-manager
```

---

**Optional: Install Wazuh Dashboard (full SIEM stack)**

Wazuh's full stack includes 3 components:

- **Wazuh Manager** – core engine
- **Wazuh Indexer** – data storage (OpenSearch-based)
- **Wazuh Dashboard** – web UI

For the full stack, the easiest method is their install script:

bash

```bash
curl -sO https://packages.wazuh.com/4.9/wazuh-install.sh
curl -sO https://packages.wazuh.com/4.9/config.yml
```

Edit `config.yml` ( I needed to install nano ) with your server's IP (find with `hostname -I`), then run:

bash

```bash
sudo bash wazuh-install.sh -a
```

---

**Firewall ports to open:**

bash

````bash
sudo firewall-cmd --permanent --add-port=1514/tcp   # Agent communication
sudo firewall-cmd --permanent --add-port=1515/tcp   # Agent enrollment
sudo firewall-cmd --permanent --add-port=443/tcp    # Dashboard
sudo firewall-cmd --permanent --add-port=9200/tcp   # Indexer API
sudo firewall-cmd --reload
```

---

**Access the dashboard:**
```
https://your-ip
````

Default credentials:

- **User:** `admin`
- **Password:** shown at end of install script outputs
## VM 4
- Prometheus - collects & stores metrics
- Grafana - Visualization
- Wazuh agent
### VM 4 Setup

#### Prometheus

#### Grafana
## VM 5
- Next Cloud
- Wazuh agent
### VM 5 Setup

#### Nextcloud
# VM Resource Allocation (32 GB Host)

> Storage: All VMs use local-lvm (NVMe, ~465 GB total). ZFS pool (zfspool, mounted at `/mnt/zfsdata`) reserved for personal files; accessed by VM 6 via NFS.

| VM               | Services                           | vCPUs | RAM           | Storage (local-lvm/NVMe) | Network                                         | Key Recommendations                                                                                                                                                          |
| ---------------- | ---------------------------------- | ----- | ------------- | ------------------------ | ----------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| VM 1             | NGINX, Reverse Proxy, Wazuh Agent  | 2     | 2 GB          | 20 GB                    | Single NIC via vmbr0; static IP; consider VLANs | NGINX is CPU-bound under TLS termination; route Nextcloud traffic through here; Wazuh agent adds ~256MB RAM overhead                                                         |
| VM 2             | PostgreSQL, Wazuh Agent            | 2     | 8 GB          | 50 GB                    | Internal only, no public exposure               | Set `shared_buffers=2GB`, `effective_cache_size=6GB`; NVMe essential for WAL and random I/O; add PgBouncer for connection pooling; maintain offsite backups                  |
| VM 3             | Wazuh Manager                      | 2     | 8 GB          | 150 GB                   | Internal; ports 1514/1515 open to agents        | Much heavier than the agent; 8 GB handles ~50–100 agents comfortably; enforce 60-day log retention policy to stay within storage budget                                      |
| VM 4             | Prometheus, Grafana, Wazuh Agent   | 2     | 6 GB          | 80 GB                    | Internal scraping access to all VMs             | Set `--storage.tsdb.retention.time` to 30 days to control disk growth; Grafana is light but spikes CPU on heavy dashboards                                                   |
| VM 5             | Nextcloud, Wazuh Agent             | 2     | 4 GB          | 50 GB                    | HTTPS via VM 1 reverse proxy                    | 50 GB for app/config only — user data should be stored on an external or network share; never expose directly — proxy through VM 1                                           |
| VM 6             | Linux Mint (Personal Files/Photos) | 2     | 4 GB          | 30 GB                    | Internal; NFS mount to zfspool                  | GUI desktop for personal photo access; NFS mount `/mnt/zfsdata/photos` from Proxmox host at `192.168.1.2`; use Cinnamon desktop with Shotwell or gThumb for photo management |
| **Proxmox Host** | —                                  | —     | 2 GB reserved | —                        | —                                               | Never allocate 100% RAM; leave host headroom for stability                                                                                                                   |

**Totals:** 12 vCPUs · 30 GB RAM (2 GB reserved for host) · 380 GB NVMe used of 465 GB available (85 GB free, ~18% headroom)

## VM 6 
- GUI enabled for desktop based access to files
- find where the zfs pool is
	- zpool list
	- zfs list -r zfspool
	- ls /mnt/zfsdata
- set up the NFS share
	```bash
	apt install nfs-kernel-server -y
	echo "/mnt/zfsdata/photos 192.168.1.0/24(rw,sync,no_subtree_check)" >> /etc/exports
	exportfs -ra
	systemctl enable --now nfs-server
	```
- downloaded the Linux mint ISO
- checked the hash
- create VM2-Personal
- 1 socket, 2 cores, 30 GB of space
Inside the linux VM mount the share
```bash
sudo apt install nfs-common -y
sudo mkdir -p /mnt/photos
sudo mount 192.168.1.2:/mnt/zfsdata/photos /mnt/photos
```
```bash
echo "192.168.1.2:/mnt/zfsdata/photos  /mnt/photos  nfs  defaults  0  0" | sudo tee -a /etc/fstab
```
```bash
# verify
ls /mnt/photos
```

Add ZFS share on CachyOS laptop
```bash
sudo pacman -S nfs-utils -y
sudo mkdir -p /mnt/photos
sudo mount 192.168.1.2:/mnt/zfsdata/photos /mnt/photos
```
```bash
echo "192.168.1.2:/mnt/zfsdata/photos  /mnt/photos  nfs  defaults  0  0" | sudo tee -a /etc/fstab
```
```bash
sudo systemctl enable --now nfs-client.target
```
```bash
ls /mnt/photos
```

