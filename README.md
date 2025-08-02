# my_home_lab

> Building a virtualized homelab on ThinkPad W541 hardware to learn SysAdmin practices through hands-on implementation

## Platform

**Hardware:** ThinkPad W541 Workstation  
**Hypervisor:** Proxmox Virtual Environment (VE)  
**Management:** Web interface via LAN connection

Proxmox VE chosen for its purpose-built design and enterprise-grade virtualization capabilities.

## Services Architecture

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
