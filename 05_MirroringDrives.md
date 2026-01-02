# Mirroring Drives using ZFS

The homelab is going into full swing. I have two 2TB seagate HDD drives I want to set up in a mirror configuration using my homelab setup running Proxmox.

First we check the filesystem with `lsblk -o NAME,SIZE,MODEL` in the proxmox shell
```
sda                  1.8T ST2000DM008-2UB102
└─sda2               1.8T 
sdb                  1.8T ST2000DM008-2FR102
├─sdb1                50M 
└─sdb2               1.8T 
nvme0n1            465.8G Samsung SSD 970 EVO 500GB
├─nvme0n1p1         1007K 
├─nvme0n1p2            1G 
└─nvme0n1p3        464.8G 
  ├─pve-swap           8G 
  ├─pve-root          96G 
  ├─pve-data_tmeta   3.4G 
  │ └─pve-data     337.9G 
  └─pve-data_tdata 337.9G 
    └─pve-data     337.9G
```
Unfortunately, the drives are formatted as NTFS. 

