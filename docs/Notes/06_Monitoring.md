# Monitoring homelab with Grafana, Prometheus, and Netdata

1) Set up a Ubuntu 24.04 LTS Server

ran `ip a` to find the server's IP address

Step 1: Install Docker & Docker Compose
SSH'd into the VM 
```
username@vms-ipadress
```
Added user to the docker group
```
whoami
sudo usermod -aG docker $(whoami)
newgrp docker
docker ps
```
Installed Docker
```
# Update packages
sudo apt update && sudo apt upgrade -y

# Install Docker dependencies
sudo apt install -y apt-transport-https ca-certificates curl software-properties-common

# Add Docker GPG key and repo
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Install Docker
sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io

# Enable Docker
sudo systemctl enable --now docker

# Install Docker Compose plugin
sudo apt install -y docker-compose-plugin

# Verify installation
docker version
docker compose version
```
Step 2: Set Up Persistent Storage
```
sudo mkdir -p /mypool/monitoring/grafana
sudo mkdir -p /mypool/monitoring/prometheus
sudo mkdir -p /mypool/monitoring/node_exporter
sudo chown -R $USER:$USER /mypool/monitoring
```
checking they exist
```
tigris@monitoringduty:~$ ls -l /mypool/monitoring
total 12
drwxr-xr-x 2 tigris tigris 4096 Jan  2 06:29 grafana
drwxr-xr-x 2 tigris tigris 4096 Jan  2 06:29 node_exporter
drwxr-xr-x 2 tigris tigris 4096 Jan  2 06:29 prometheus
```
Step 3: Create a Docker Compose File
```
nano /mypool/monitoring/docker-compose.yml
```
insert the following
```
version: "3.8"

services:
  prometheus:
    image: prom/prometheus:latest
    container_name: prometheus
    volumes:
      - /mypool/monitoring/prometheus:/prometheus
      - ./prometheus.yml:/etc/prometheus/prometheus.yml
    command:
      - "--config.file=/etc/prometheus/prometheus.yml"
    ports:
      - "9090:9090"
    restart: unless-stopped

  grafana:
    image: grafana/grafana:latest
    container_name: grafana
    environment:
      - GF_SECURITY_ADMIN_PASSWORD=changeme
    volumes:
      - /mypool/monitoring/grafana:/var/lib/grafana
    ports:
      - "3000:3000"
    depends_on:
      - prometheus
    restart: unless-stopped

  node_exporter:
    image: prom/node-exporter:latest
    container_name: node_exporter
    ports:
      - "9100:9100"
    restart: unless-stopped
```
Ctrl + X --> yes

Step 4: Create Prometheus Config
```
nano /mypool/monitoring/prometheus.yml
```
```
global:
  scrape_interval: 15s

scrape_configs:
  - job_name: 'prometheus'
    static_configs:
      - targets: ['localhost:9090']

  - job_name: 'node_exporter'
    static_configs:
      - targets: ['node_exporter:9100']
```
> This config tells Prometheus to scrape itself and Node Exporter every 15 seconds.

Step 5: Launch the Stack
```
cd /mypool/monitoring
docker compose up -d
```
Grafana → http://<VM-IP>:3000

-- Login: admin / changeme

Prometheus → http://<VM-IP>:9090

Node Exporter metrics → http://<VM-IP>:9100/metrics

Step 6: Connect Grafana to Prometheus

- In Grafana → Settings → Data Sources → Add → Prometheus

- URL: http://prometheus:9090 (if using Docker network) or http://<VM-IP>:9090

- Click Save & Test

> note: this was not working for me initially so I needed to run the following to change the ownership of the folders to match the container user
```
# Grafana
sudo chown -R 472:472 /mypool/monitoring/grafana

# Prometheus
sudo chown -R 65534:65534 /mypool/monitoring/prometheus
```
Then, I brought the containers down and back up again
```
docker compose down
docker compose up -d
```




