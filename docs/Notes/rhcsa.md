# RHCSA Study Roadmap

**Target:** Red Hat Certified System Administrator (EX200)\
**Timeline:** 6 months · ~5 hrs/week · ~130 hrs total

---

## Overview

The RHCSA exam tests hands-on competency — every objective is performed live in a terminal with no internet access. This roadmap prioritizes **doing over reading**: lab time should make up at least 60% of your study hours. Your existing AlmaLinux homelab is a major asset here; nearly every objective can be practiced directly on your VMs.

---

## Exam Objective Domains

| Domain | Coverage |
|---|---|
| Understand and use essential tools | ~15% |
| Create simple shell scripts | ~10% |
| Operate running systems | ~15% |
| Configure local storage | ~15% |
| Create and configure file systems | ~15% |
| Deploy, configure, and maintain systems | ~15% |
| Manage basic networking | ~10% |
| Manage users and groups | ~10% |
| Manage security (SELinux, firewalld) | ~15% |

> Note: Red Hat doesn't publish exact weights. The above reflects community consensus from exam reports.

---

## Month-by-Month Plan

### Month 1 — Essential Tools & Shell Basics

**~20 hrs** · 5 hrs/week

**Goal:** Be completely fluent in the command line. These skills underpin every other domain.

**Topics:**
- Shell navigation, redirection (`>`, `>>`, `2>`, `|`, `tee`)
- File management: `find`, `grep`, `awk`, `sed`, `cut`, `sort`, `uniq`
- `vim` — you must be able to edit files fast under exam pressure
- Archiving and compression: `tar`, `gzip`, `bzip2`, `xz`
- Hard and soft links, file permissions (`chmod`, `chown`, `umask`)
- Input/output redirection and here-documents

**Lab tasks:**
- Practice all `find` variants: by name, size, mtime, permissions, and with `-exec`
- Write a script that archives a directory, timestamps the file, and logs the result
- Set up a `vim` config (`.vimrc`) with line numbers, syntax highlighting, and 4-space tabs

**Resources:**
- `man` and `--help` — get comfortable reading man pages fast
- *The Linux Command Line* by William Shotts (free at linuxcommand.org)
- Red Hat's own `pinfo bash`

---

### Month 2 — Users, Groups, Permissions & Storage Basics
**~20 hrs** · 5 hrs/week

**Goal:** Confidently manage users and understand block storage from disk to mount.

**Topics:**
- Users and groups: `useradd`, `usermod`, `groupadd`, `passwd`, `/etc/passwd`, `/etc/shadow`
- `sudo` and `/etc/sudoers` (visudo) — you've already touched this in your homelab
- Special permissions: SUID, SGID, sticky bit
- Partitioning with `fdisk` and `gdisk` (MBR vs GPT)
- Physical volumes, volume groups, logical volumes (LVM)
- Extending and reducing LVM volumes

**Lab tasks:**
- Create users with specific UIDs, shells, and home directories
- Configure `sudo` rules: allow a user to run only specific commands
- Partition a virtual disk, create a VG and LV, format it ext4, and add it to `/etc/fstab`
- Practice extending an LV while it's mounted

**Resources:**
- `man 5 fstab`, `man lvm`, `man fdisk`
- Your AlmaLinux VMs — add a small virtual disk in Proxmox to practice on safely

---

### Month 3 — File Systems, Networking & Package Management
**~20 hrs** · 5 hrs/week

**Goal:** Own file system configuration and get comfortable with AlmaLinux's network stack.

**Topics:**
- `xfs` (default on RHEL/AlmaLinux) and `ext4` filesystem creation and tuning
- Mounting: options, persistent mounts via `/etc/fstab`, `systemd.mount`
- `autofs` for automounting
- NFS server and client configuration — you already have this running for ZFS
- `nmcli` and `nmtui` for network configuration (static IPs, DNS, bonding basics)
- `dnf`: installing, removing, updating, querying packages; working with repos
- `rpm`: querying installed packages, verifying files

**Lab tasks:**
- Configure a static IP on one of your VMs using only `nmcli`
- Mount an NFS share persistently via `/etc/fstab` and via `autofs`
- Create an XFS filesystem on an LV, mount it, and verify with `df -hT` and `blkid`
- Set up a local DNF repo from an ISO

**Resources:**
- `man nmcli-examples` — genuinely useful
- Your existing NFS setup is direct exam prep; document what you did in your `sysadmin_handbook`

---

### Month 4 — Systemd, Boot Process & System Maintenance
**~20 hrs** · 5 hrs/week

**Goal:** Understand how the system starts, breaks, and recovers. This domain trips up many candidates.

**Topics:**
- `systemd`: units, targets, `systemctl` (enable, start, mask, daemon-reload)
- Writing and modifying service unit files
- Boot process: GRUB2, kernel parameters, `rd.break`, emergency/rescue targets
- Resetting root password (a near-certain exam task)
- `journald` and `journalctl`: filtering by unit, time, priority
- `tuned` profiles and `at`/`cron` scheduling

**Lab tasks:**
- Boot a VM into `rd.break` and reset root's password — practice until it takes under 3 minutes
- Write a custom systemd service that runs a script on boot
- Break a service intentionally (bad unit file), diagnose with `journalctl -xe`, and fix it
- Configure a `cron` job and verify it with `systemctl status crond`

**Resources:**
- `man systemd.unit`, `man systemd.service`
- Your Wazuh and Prometheus VMs are real systemd service practice

---

### Month 5 — SELinux, Firewalld & Security
**~20 hrs** · 5 hrs/week

**Goal:** This is where most RHCSA candidates lose points. SELinux especially requires hands-on confidence.

**Topics:**
- SELinux modes: enforcing, permissive, disabled (`setenforce`, `getenforce`, `/etc/selinux/config`)
- Contexts: `ls -Z`, `ps -Z`, `chcon`, `restorecon`, `semanage fcontext`
- Troubleshooting SELinux denials: `ausearch`, `sealert`, `/var/log/audit/audit.log`
- Booleans: `getsebool`, `setsebool -P`
- `firewalld`: zones, services, ports, permanent vs runtime rules (`firewall-cmd`)
- SSH configuration: key-based auth, `sshd_config` options

**Lab tasks:**
- Move a web directory to a non-standard path and fix it with `semanage fcontext` + `restorecon`
- Introduce an SELinux denial intentionally and trace it end-to-end through `ausearch`
- Configure `firewalld` to allow HTTP/HTTPS permanently and block a specific port
- Set up SSH key auth and disable password auth on a VM

**Resources:**
- `man semanage-fcontext`, `man ausearch`
- Your Wazuh SIEM is perfect for reviewing audit log entries generated by your own SELinux work

---

### Month 6 — Review, Weak Spots & Timed Practice
**~20 hrs** · 5 hrs/week

**Goal:** Exam-ready. No gaps, consistent speed, no notes needed.

**Week 1–2: Systematic review**
Go through the official RHCSA exam objectives one by one. For each, ask: *Can I do this from scratch in under 5 minutes without looking anything up?* Mark anything that isn't a confident yes.

**Week 3: Gap fill**
Drill only your weak areas. Common ones:
- `autofs` (many candidates skip this)
- LVM thin provisioning
- Container basics with `podman` (added in RHEL 9 objectives — confirm current exam version)
- `stratis` storage (RHEL 9)

**Week 4: Timed full labs**
Run 2–3 full mock exams under time pressure (3 hours). Reset a VM to a clean snapshot, complete all tasks, then check your work.

**Resources:**
- Sander van Vugt's RHCSA 9 course (Pearson/O'Reilly) — widely considered the best single resource
- Asghar Ghori's *RHCSA Red Hat Enterprise Linux 9* book
- `rhcsa-practice-questions` on GitHub (search for maintained repos)

---

## Homelab Integration

Your existing setup maps directly to exam objectives:

| Homelab Resource | RHCSA Objective |
|---|---|
| AlmaLinux VMs on Proxmox | All objectives — add/remove vdisks for storage practice |
| ZFS pool + NFS export | NFS server config, autofs, fstab mounts |
| Nginx VM | SELinux contexts, firewalld, systemd service management |
| PostgreSQL VM | systemd services, socket activation, firewalld |
| Wazuh VM | journalctl, audit logs, SELinux troubleshooting |
| Prometheus/Grafana VM | systemd unit files, networking |

**Recommended practice pattern:** Before each lab session, take a Proxmox snapshot. After the lab, either restore the snapshot to redo from scratch, or keep the state and move to the next task. The restore-and-repeat approach on tasks like root password reset and SELinux context fixes is the single most effective exam prep technique.

---

## Weekly Time Budget (5 hrs)

| Activity | Time |
|---|---|
| Concept reading / video | 1 hr |
| Guided lab (following a tutorial) | 1.5 hrs |
| Independent lab (no notes) | 1.5 hrs |
| `sysadmin_handbook` documentation | 1 hr |

Documenting your labs in your handbook is not optional busywork — writing out what you did and why is one of the most effective retention techniques, and it builds the same mental model the exam tests.

---

## Key Exam Day Tips

- **Speed matters as much as accuracy.** You have 3 hours for ~20 tasks. That's ~9 minutes per task with no buffer. Practice fast.
- **Read every task twice before touching the keyboard.** Misreading a task (e.g., setting a persistent vs runtime firewall rule) is the most common failure mode.
- **Don't skip and come back unless you're truly stuck.** Partial credit is not guaranteed; a completed wrong task may score zero.
- **Reboot before you're done.** Many settings only prove correct after a reboot (`fstab` entries, SELinux contexts, systemd services set to `enable`). Leave 10–15 minutes at the end to reboot and verify.
- **The exam runs on RHEL, not AlmaLinux.** They are nearly identical, but confirm any version-specific behavior (e.g., `podman` vs `docker`, `stratis` vs standard LVM).

---

## Recommended Resources

| Resource | Type | Notes |
|---|---|---|
| Sander van Vugt RHCSA 9 | Video course | Best overall; covers all objectives with labs |
| Asghar Ghori *RHCSA Red Hat Enterprise Linux 9* | Book | Dense but comprehensive; good reference |
| Red Hat official exam objectives | Webpage | The authoritative checklist — verify against this monthly |
| `rhcsa-practice-questions` (GitHub) | Practice | Several maintained repos; verify they match your RHEL version |
| Your `sysadmin_handbook` | Notes | Your own documentation is an underrated study resource |

---

*Last updated: March 2026 · Targets RHCSA EX200 on RHEL 9*
