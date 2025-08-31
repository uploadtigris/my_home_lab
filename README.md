# my_home_lab

> Building a virtualized homelab on ThinkPad W541 hardware to learn SysAdmin practices through hands-on implementation \
> TODO: Need to get HDD enclosue for my 2, 2TB HDD drives

## Platform

**Hardware:** ThinkPad W541 Workstation  
**Hypervisor:** Proxmox Virtual Environment (VE)  
**Management:** Web interface via LAN connection

Proxmox VE chosen for its purpose-built design and enterprise-grade virtualization capabilities.

## Services Architecture

```
Physical Hardware
└── Proxmox VE (Host OS - Debian-based)
    ├── VM 1: Ubuntu Server 24.04 LTS (Media Server)
    │   ├── Plex/Jellyfin
    │   ├── Sonarr/Radarr  
    │   └── qBittorrent
    ├── VM 2: Ubuntu Server 24.04 LTS (Storage Server)
    │   ├── Nextcloud
    │   ├── Duplicati
    │   └── Syncthing
    └── VM 3: Ubuntu Server 24.04 LTS (Network Services)
        ├── Pi-hole
        ├── Nginx Proxy Manager
        └── Uptime Kuma
```

### Service Resource Distribution

```
# VM 1: Media Server
- OS: Debian 13
- Total Memory Allocation: 8 GB
- Cores: 1
- Sockets: 1
    - Plex/Jellyfin: 4 GB
    - Sonarr/Radarr: 2 GB
    - qBittorrent: 2 GB

# VM 2: Storage Server
- OS: Debian 13
- Total Memory Allocation: 8 GB
- Storage Allocation: 500 GB
- Cores: 1
- Sockets: 1
    - Nextcloud: Primary storage user; will consume most of the 500 GB for file storage.
    - Duplicati: Backs up data, requiring minimal local storage for its database.
    - Syncthing: Synchronizes files; its storage use will be within the shared 500 GB.

# VM 3: Network Services
- OS: Debian 13
- Total Memory Allocation: 2 GB
- Storage Allocation: 20 GB
- Cores: 1
- Sockets: 1
    - Pi-hole: Requires minimal space for logs and blocklists.
    - Nginx Proxy Manager: Requires minimal space for configuration and certificates.
    - Uptime Kuma: Requires minimal space for monitoring data.
```
# VM 1: Media Server
- OS: Debian 13
- *Total Memory Allocation: 8 GB*
- Cores: 1
- Sockets: 1
    - Plex/Jellyfin: 4 GB
    - Sonarr/Radarr: 2 GB
    - qBittorrent: 2 GB

# VM 2: Storage Server
- OS: Debian 13
- *Total Memory Allocation: 8 GB*
- Cores: 1
- Sockets: 1
    - Nextcloud: 4 GB
    - Duplicati: 2 GB
    - Syncthing: 2 GB

# VM 3: Network Services
- OS: Debian 13
- *Total Memory Allocation: 2 GB*
- Cores: 1
- Sockets: 1
    - Pi-hole: 0.5 GB
    - Nginx Proxy Manager: 0.5 GB
    - Uptime Kuma: 1 GB
```

### 1. Automated Backup & Cloud Storage Server
**Technologies:**
- Nextcloud - Self-hosted cloud platform
- Duplicati/Restic - Automated backup solutions  
- Syncthing - File synchronization

### 2. Media Server
**Technologies:**
- Plex/Jellyfin - Media streaming
- Sonarr/Radarr - Automated content management
- qBittorrent - Download management

### 3. Networking Services
**Technologies:**
- Pi-hole - DNS and ad blocking
- Nginx Proxy Manager - Reverse proxy and SSL
- Uptime Kuma - Service monitoring

## Learning Objectives

- Virtualization and resource management
- Container deployment with Docker
- Network security and SSL certificate automation
- Backup strategies and disaster recovery
- Infrastructure monitoring and alerting
- Configuration management and documentation

## Goals

- Achieve reliable self-hosted infrastructure
- Eliminate dependency on cloud storage providers
- Master essential SysAdmin workflows
- Build comprehensive monitoring and backup systems
