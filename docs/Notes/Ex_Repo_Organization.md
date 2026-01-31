```
homelab/
│
├── README.md
├── .gitignore
│
├── notes/
│   ├── rhcsa/
│   │   ├── week-01-fundamentals.md
│   │   ├── week-02-shell-basics.md
│   │   ├── week-03-file-management.md
│   │   ├── week-04-text-processing.md
│   │   ├── week-05-processes.md
│   │   ├── week-06-users-groups.md
│   │   ├── week-07-storage.md
│   │   ├── week-08-lvm.md
│   │   ├── week-09-networking.md
│   │   ├── week-10-services.md
│   │   ├── week-11-selinux.md
│   │   └── week-12-review.md
│   │
│   ├── rhce/
│   │   ├── ansible-basics.md
│   │   ├── playbooks.md
│   │   ├── roles.md
│   │   ├── templates-jinja2.md
│   │   ├── variables-facts.md
│   │   ├── conditionals-loops.md
│   │   ├── handlers.md
│   │   ├── ansible-vault.md
│   │   └── troubleshooting.md
│   │
│   ├── linux-topics/
│   │   ├── systemd.md
│   │   ├── selinux.md
│   │   ├── lvm-cheatsheet.md
│   │   ├── firewalld.md
│   │   ├── networking.md
│   │   ├── ssh.md
│   │   └── vim-commands.md
│   │
│   └── practice-labs/
│       ├── lab-01-users.md
│       ├── lab-02-permissions.md
│       ├── lab-03-storage.md
│       ├── lab-04-networking.md
│       └── lab-05-ansible.md
│
├── ansible/
│   ├── ansible.cfg
│   ├── inventory.yml
│   │
│   ├── playbooks/
│   │   ├── setup-new-server.yml
│   │   ├── pihole.yml
│   │   ├── nginx.yml
│   │   ├── update-systems.yml
│   │   ├── user-management.yml
│   │   └── backup.yml
│   │
│   ├── roles/
│   │   ├── common/
│   │   │   ├── tasks/
│   │   │   │   └── main.yml
│   │   │   ├── handlers/
│   │   │   │   └── main.yml
│   │   │   ├── templates/
│   │   │   ├── files/
│   │   │   └── defaults/
│   │   │       └── main.yml
│   │   │
│   │   ├── pihole/
│   │   │   ├── tasks/
│   │   │   │   └── main.yml
│   │   │   ├── templates/
│   │   │   └── defaults/
│   │   │       └── main.yml
│   │   │
│   │   └── nginx/
│   │       ├── tasks/
│   │       │   └── main.yml
│   │       ├── templates/
│   │       └── defaults/
│   │           └── main.yml
│   │
│   └── group_vars/
│       └── all.yml
│
├── scripts/
│   ├── setup/
│   │   ├── initial-vm-setup.sh
│   │   ├── install-ansible.sh
│   │   └── ssh-key-setup.sh
│   │
│   ├── backup/
│   │   ├── backup-configs.sh
│   │   ├── backup-homelab.sh
│   │   └── restore.sh
│   │
│   ├── system/
│   │   ├── update-all.sh
│   │   ├── disk-usage-check.sh
│   │   ├── service-health-check.sh
│   │   └── cleanup-old-kernels.sh
│   │
│   └── network/
│       ├── port-scan.sh
│       ├── test-connectivity.sh
│       └── dns-check.sh
│
├── configs/
│   ├── nginx/
│   │   ├── nginx.conf
│   │   ├── reverse-proxy.conf
│   │   └── sites/
│   │       ├── pihole.conf
│   │       └── nextcloud.conf
│   │
│   ├── docker/
│   │   ├── docker-compose-monitoring.yml
│   │   ├── docker-compose-media.yml
│   │   └── Dockerfile.custom
│   │
│   ├── systemd/
│   │   ├── backup.service
│   │   ├── backup.timer
│   │   └── custom-app.service
│   │
│   ├── ssh/
│   │   └── sshd_config
│   │
│   └── firewalld/
│       └── custom-rules.xml
│
└── docs/
    ├── services/
    │   ├── pihole-setup.md
    │   ├── nginx-setup.md
    │   ├── nextcloud-setup.md
    │   └── monitoring-setup.md
    │
    ├── infrastructure/
    │   ├── proxmox-setup.md
    │   ├── network-diagram.md
    │   └── vm-templates.md
    │
    └── troubleshooting/
        ├── common-issues.md
        └── debug-playbooks.md
```

# Repository Directory Structure

## `/notes/`
Your learning journal and reference materials:

- **`rhcsa/`** - Week-by-week study notes following your 12-week plan
- **`rhce/`** - Ansible-focused notes for RHCE prep
- **`linux-topics/`** - Quick reference cheatsheets for common topics
- **`practice-labs/`** - Hands-on lab exercises you complete

## `/ansible/`
All automation code:

- **`playbooks/`** - Standalone playbooks for specific tasks
- **`roles/`** - Reusable role-based automation (RHCE practice)
- **`ansible.cfg`** - Ansible configuration
- **`inventory.yml`** - Your server inventory (production/test)
- **`group_vars/`** - Variables for groups of servers

## `/scripts/`
Quick bash scripts for common sysadmin tasks:

- **`setup/`** - Initial setup and configuration scripts
- **`backup/`** - Backup and restore automation
- **`system/`** - Maintenance and monitoring scripts
- **`network/`** - Network diagnostics and testing

## `/configs/`
Configuration file templates and examples:

- Service configs (nginx, docker, systemd)
- Can be used by Ansible or manually deployed
- Version controlled for easy rollback

## `/docs/`
Documentation for your homelab:

- Service setup guides
- Infrastructure documentation
- Troubleshooting guides