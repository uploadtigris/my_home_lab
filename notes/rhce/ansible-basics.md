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
