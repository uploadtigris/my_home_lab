# Pi-hole Setup Guide

## Manual Installation

1. Install dependencies:
```bash
sudo dnf install -y curl
```

2. Run installer:
```bash
curl -sSL https://install.pi-hole.net | bash
```

3. Follow prompts

## Ansible Deployment

```bash
ansible-playbook ansible/playbooks/pihole.yml
```

## Configuration

- Web interface: http://pi-hole-ip/admin
- Default password: (set during install)
- DNS: Point clients to Pi-hole IP

## Maintenance

Update Pi-hole:
```bash
pihole -up
```

View logs:
```bash
pihole -t
```
