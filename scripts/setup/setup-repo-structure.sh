#!/bin/bash

################################################################################
# Homelab Repository Structure Setup Script
# 
# This script creates the complete directory structure for the homelab
# repository including notes, ansible configs, scripts, and documentation.
#
# Usage: ./setup-repo-structure.sh [target_directory]
# If no directory is specified, creates structure in current directory
################################################################################

set -e  # Exit on error

# Color codes for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Target directory (default to current directory)
TARGET_DIR="${1:-.}"

echo -e "${BLUE}========================================${NC}"
echo -e "${BLUE}  Homelab Repository Structure Setup${NC}"
echo -e "${BLUE}========================================${NC}"
echo ""
echo -e "${YELLOW}Target directory: ${TARGET_DIR}${NC}"
echo ""

# Create directory structure
echo -e "${GREEN}Creating directory structure...${NC}"

# Main directories
mkdir -p "${TARGET_DIR}"/{notes,ansible,scripts,configs,docs}

# Notes directories
mkdir -p "${TARGET_DIR}/notes"/{rhcsa,rhce,linux-topics,practice-labs}

# Ansible directories
mkdir -p "${TARGET_DIR}/ansible"/{playbooks,roles,group_vars}
mkdir -p "${TARGET_DIR}/ansible/roles"/{common,pihole,nginx}

# Create role subdirectories for each role
for role in common pihole nginx; do
    mkdir -p "${TARGET_DIR}/ansible/roles/${role}"/{tasks,handlers,templates,files,defaults}
done

# Scripts directories
mkdir -p "${TARGET_DIR}/scripts"/{setup,backup,system,network}

# Configs directories
mkdir -p "${TARGET_DIR}/configs"/{nginx,docker,systemd,ssh,firewalld}
mkdir -p "${TARGET_DIR}/configs/nginx/sites"

# Docs directories
mkdir -p "${TARGET_DIR}/docs"/{services,infrastructure,troubleshooting}

echo -e "${GREEN}✓ Directory structure created${NC}"
echo ""

# Create placeholder files
echo -e "${GREEN}Creating placeholder files...${NC}"

# Root files
cat > "${TARGET_DIR}/.gitignore" << 'EOF'
# Ansible
*.retry
group_vars/vault.yml
host_vars/vault.yml

# Python
__pycache__/
*.py[cod]
*$py.class
*.so
.Python

# Virtual environments
venv/
ENV/
env/

# Terraform
.terraform/
*.tfstate
*.tfstate.*
.terraform.lock.hcl

# Secrets and credentials
*.key
*.pem
*_rsa
*_rsa.pub
secrets/
credentials/

# OS
.DS_Store
Thumbs.db
*.swp
*.swo
*~

# Logs
*.log

# Backups
*.bak
*.backup

# Personal notes that shouldn't be committed
PRIVATE.md
TODO-personal.md
EOF

# RHCSA notes templates
for i in {01..12}; do
    week_file="${TARGET_DIR}/notes/rhcsa/week-${i}.md"
    if [ ! -f "$week_file" ]; then
        cat > "$week_file" << EOF
# Week ${i} - RHCSA Study Notes

## Topics Covered
- Topic 1
- Topic 2
- Topic 3

## Key Commands
\`\`\`bash
# Command examples here
\`\`\`

## Important Concepts
- Concept 1
- Concept 2

## Practice Exercises
1. Exercise 1
2. Exercise 2

## Questions/Review
- [ ] Topic to review
- [ ] Command to practice

## Resources
- Linux Bible: Chapter X
- How Linux Works: Chapter Y
EOF
    fi
done

# RHCE notes templates
cat > "${TARGET_DIR}/notes/rhce/ansible-basics.md" << 'EOF'
# Ansible Basics

## Installation
```bash
# RHEL/AlmaLinux
sudo dnf install ansible-core

# Verify installation
ansible --version
```

## Configuration
- Config file: `/etc/ansible/ansible.cfg` or `~/.ansible.cfg`
- Inventory: `/etc/ansible/hosts` or custom location

## Ad-hoc Commands
```bash
# Ping all hosts
ansible all -m ping

# Check disk space
ansible all -m shell -a "df -h"

# Install package
ansible webservers -m dnf -a "name=httpd state=present"
```

## Notes
- Always use `ansible-doc` to check module documentation
- Test with `-C` (check mode) before running
EOF

cat > "${TARGET_DIR}/notes/linux-topics/systemd.md" << 'EOF'
# Systemd Cheatsheet

## Service Management
```bash
# Start/stop/restart service
systemctl start service_name
systemctl stop service_name
systemctl restart service_name

# Enable/disable service (autostart)
systemctl enable service_name
systemctl disable service_name

# Check status
systemctl status service_name

# View logs
journalctl -u service_name
journalctl -u service_name -f  # Follow logs
```

## Unit Files
Location: `/etc/systemd/system/`

Basic structure:
```ini
[Unit]
Description=My Service
After=network.target

[Service]
Type=simple
ExecStart=/path/to/executable
Restart=on-failure

[Install]
WantedBy=multi-user.target
```

## Useful Commands
```bash
# Reload systemd after changes
systemctl daemon-reload

# List all services
systemctl list-units --type=service

# List failed services
systemctl --failed
```
EOF

# Ansible configuration
cat > "${TARGET_DIR}/ansible/ansible.cfg" << 'EOF'
[defaults]
inventory = inventory.yml
remote_user = ansible
host_key_checking = False
retry_files_enabled = False
gathering = smart
fact_caching = jsonfile
fact_caching_connection = /tmp/ansible_facts
fact_caching_timeout = 3600

[privilege_escalation]
become = True
become_method = sudo
become_user = root
become_ask_pass = False

[ssh_connection]
pipelining = True
EOF

cat > "${TARGET_DIR}/ansible/inventory.yml" << 'EOF'
---
all:
  children:
    production:
      hosts:
        desktop:
          ansible_host: 192.168.1.10
        proxmox:
          ansible_host: 192.168.1.11
    
    development:
      hosts:
        thinkpad:
          ansible_host: 192.168.1.20

    webservers:
      hosts:
        desktop:

    monitoring:
      hosts:
        desktop:
EOF

cat > "${TARGET_DIR}/ansible/group_vars/all.yml" << 'EOF'
---
# Global variables for all hosts

# Common packages to install on all systems
common_packages:
  - vim
  - git
  - htop
  - curl
  - wget

# Timezone
timezone: America/Chicago

# SSH settings
ssh_port: 22
EOF

# Sample playbook
cat > "${TARGET_DIR}/ansible/playbooks/setup-new-server.yml" << 'EOF'
---
- name: Setup new server with common configuration
  hosts: all
  become: yes
  
  tasks:
    - name: Update all packages
      dnf:
        name: "*"
        state: latest
      when: ansible_os_family == "RedHat"
    
    - name: Install common packages
      dnf:
        name: "{{ common_packages }}"
        state: present
      when: ansible_os_family == "RedHat"
    
    - name: Set timezone
      timezone:
        name: "{{ timezone }}"
    
    - name: Ensure firewalld is running
      systemd:
        name: firewalld
        state: started
        enabled: yes
EOF

# Sample role
cat > "${TARGET_DIR}/ansible/roles/common/tasks/main.yml" << 'EOF'
---
# Common role - tasks to run on all systems

- name: Update package cache
  dnf:
    update_cache: yes
  when: ansible_os_family == "RedHat"

- name: Install common packages
  dnf:
    name: "{{ common_packages }}"
    state: present

- name: Set timezone
  timezone:
    name: "{{ timezone }}"

- name: Configure SSH
  template:
    src: sshd_config.j2
    dest: /etc/ssh/sshd_config
    owner: root
    group: root
    mode: '0600'
  notify: restart sshd
EOF

cat > "${TARGET_DIR}/ansible/roles/common/handlers/main.yml" << 'EOF'
---
# Common handlers

- name: restart sshd
  systemd:
    name: sshd
    state: restarted
EOF

cat > "${TARGET_DIR}/ansible/roles/common/defaults/main.yml" << 'EOF'
---
# Default variables for common role

common_packages:
  - vim
  - git
  - htop
  - curl
  - wget
  - tmux

timezone: America/Chicago
EOF

# Sample scripts
cat > "${TARGET_DIR}/scripts/setup/initial-vm-setup.sh" << 'EOF'
#!/bin/bash
# Initial VM setup script

set -e

echo "Starting initial VM setup..."

# Update system
echo "Updating system packages..."
sudo dnf update -y

# Install basic tools
echo "Installing basic tools..."
sudo dnf install -y vim git htop curl wget

# Set timezone
echo "Setting timezone..."
sudo timedatectl set-timezone America/Chicago

# Enable firewall
echo "Enabling firewall..."
sudo systemctl enable --now firewalld

echo "Initial setup complete!"
EOF

chmod +x "${TARGET_DIR}/scripts/setup/initial-vm-setup.sh"

cat > "${TARGET_DIR}/scripts/backup/backup-configs.sh" << 'EOF'
#!/bin/bash
# Backup configuration files

BACKUP_DIR="${HOME}/backups/configs"
DATE=$(date +%Y%m%d_%H%M%S)

mkdir -p "${BACKUP_DIR}"

echo "Backing up configurations to ${BACKUP_DIR}/backup_${DATE}.tar.gz"

tar -czf "${BACKUP_DIR}/backup_${DATE}.tar.gz" \
    /etc/nginx/ \
    /etc/ssh/sshd_config \
    /etc/systemd/system/ \
    2>/dev/null

echo "Backup complete!"
EOF

chmod +x "${TARGET_DIR}/scripts/backup/backup-configs.sh"

cat > "${TARGET_DIR}/scripts/system/update-all.sh" << 'EOF'
#!/bin/bash
# Update all systems

echo "Updating system packages..."
sudo dnf update -y

echo "Cleaning up old packages..."
sudo dnf autoremove -y

echo "Update complete!"
EOF

chmod +x "${TARGET_DIR}/scripts/system/update-all.sh"

# Sample documentation
cat > "${TARGET_DIR}/docs/services/pihole-setup.md" << 'EOF'
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
EOF

cat > "${TARGET_DIR}/docs/infrastructure/proxmox-setup.md" << 'EOF'
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
EOF

echo -e "${GREEN}✓ Placeholder files created${NC}"
echo ""

# Summary
echo -e "${BLUE}========================================${NC}"
echo -e "${GREEN}✓ Setup Complete!${NC}"
echo -e "${BLUE}========================================${NC}"
echo ""
echo "Directory structure created at: ${TARGET_DIR}"
echo ""
echo "Next steps:"
echo "1. Review and customize ansible/inventory.yml with your server IPs"
echo "2. Start taking notes in notes/rhcsa/"
echo "3. Test ansible connection: cd ${TARGET_DIR} && ansible all -m ping"
echo "4. Create your first playbook in ansible/playbooks/"
echo ""
echo -e "${YELLOW}Happy learning!${NC}"