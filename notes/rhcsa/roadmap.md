# RHCSA Study Timeline — 6 Months

## Weeks 1–3 — Foundation
- File system hierarchy and navigation
- File permissions (chmod, chown, ACLs)
- `find` command (by permission, owner, size, mtime)
- `tar` and file archiving
- Users and groups
- Package management (dnf)
- Basic shell scripting
- Cron and at jobs

## Weeks 4–6 — System Management
- SSH configuration
- Boot process overview
- systemd units and targets
- journalctl and logging
- Tuned profiles (`tuned-adm`)
- Kernel parameters (`sysctl`)
- Time sync with chrony
- Hostname, DNS, and NetworkManager

## Weeks 7–9 — Storage
- Partitioning (fdisk, parted)
- `/etc/fstab` and persistent mounts (deep focus)
- LVM (pvcreate, vgcreate, lvcreate, extending/reducing)
- Stratis storage
- VDO volumes
- firewalld
- NFS mounts
- autofs

## Weeks 10–13 — SELinux & Containers
- SELinux modes and policies
- `chcon` and `restorecon`
- `audit2allow` and audit logs
- `semanage` (ports, fcontexts, booleans)
- Podman containers (deep focus)
- Podman + systemd unit file generation
- Boot target recovery and root password reset drills

## Weeks 14–18 — Consolidation & Weak Spots
- Revisit any topics that felt shaky
- Build a personal cheat sheet of commands (from memory)
- Timed task drills (15–30 min exercises)
- Break-fix scenario practice
- Speed drills on high-frequency tasks

## Weeks 19–24 — Exam Simulation
- Full timed mock exams (realistic RHEL 9 VM environment)
- Root password reset drills
- Identify and systematically close weak spots
- One full mock exam per week minimum
- Final review of all objectives one week before exam
