# Proxmox Laptop Lid Close Fix

## Problem
Proxmox server (laptop) would suspend/sleep when lid was closed, making it unreachable.

## Failed Solutions
- Editing `/etc/systemd/logind.conf` with `HandleLidSwitch=ignore` settings
- Restarting `systemd-logind` service

## Working Solution
```bash
systemctl mask sleep.target suspend.target hibernate.target hybrid-sleep.target
```

## Result
System now continues running with lid closed and remains network accessible.

## Notes
The systemd logind configuration approach failed, likely due to older systemd version or hardware-level power management overrides. The masking approach completely disables all sleep/suspend functionality at the systemd target level.
