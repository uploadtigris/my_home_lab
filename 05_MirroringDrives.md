# Mirroring Drives using ZFS

The homelab is going into full swing. I have two 2TB Seagate HDD drives I want to set up in a mirror configuration using my homelab setup running Proxmox.

"Mirroring" these drives with the RAID1 configuration means that if one drive goes bad, there is a full copy of the data on the other. 

---

## 1. Check Existing Drives

Check the current drives and partitions:

```bash
lsblk -o NAME,SIZE,MODEL
````

Example output:

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

> The drives are currently NTFS, which is not ideal for Proxmox. We need to back up the data first.

---

## 2. Mount the Source Drive

Mount `/dev/sda2` to access the files:

```bash
mkdir -p /mnt/check
mount -t ntfs-3g /dev/sda2 /mnt/check
df -h /mnt/check
```

Example output:

```
Filesystem      Size  Used Avail Use% Mounted on
/dev/sdb2       1.9T   58G  1.8T   4% /mnt/check
```

---

## 3. Prepare the Backup Drive

Format and mount `/dev/sdc` as ext4:

```bash
umount /dev/sdc1
mkfs.ext4 -L BackupDrive /dev/sdc
mkdir -p /mnt/backup
mount /dev/sdc /mnt/backup
df -h /mnt/backup
```

---

## 4. Verify Source and Destination

Check contents of the source:

```bash
df -h /mnt/check
ls -l /mnt/check
```

Example:

```
Filesystem      Size  Used Avail Use% Mounted on
/dev/sdb2       1.9T   58G  1.8T   4% /mnt/check
total 24
drwxrwxrwx 1 root root    0 Mar  4  2025 '$RECYCLE.BIN'
drwxrwxrwx 1 root root 4096 Aug  4 12:14  2021
drwxrwxrwx 1 root root    0 Aug  4 13:46  photos
drwxrwxrwx 1 root root 4096 Mar  4  2025 'System Volume Information'
drwxrwxrwx 1 root root    0 Feb 28  2025 'tax things'
drwxrwxrwx 1 root root 8192 Aug  4 12:14  texts
drwxrwxrwx 1 root root    0 Jul  9 11:14  ut-austin
drwxrwxrwx 1 root root 4096 Aug  4 12:19  wallpapers
drwxrwxrwx 1 root root 4096 Aug  4 12:21  writing
```

---

## 5. Copy Data to Backup Drive

```bash
rsync -avh --progress /mnt/check/ /mnt/backup/
```

Verify sizes:

```bash
du -sh /mnt/check
du -sh /mnt/backup
```

---

## 6. Wipe Old Drives for ZFS

Check for mounted drives:

```bash
mount | grep sda
mount | grep sdb
```

Unmount if necessary:

```bash
umount /dev/sda*
umount /dev/sdb*
```

Wipe filesystem signatures:

```bash
wipefs -a /dev/sda
wipefs -a /dev/sdb
```

Confirm drives are clean:

```bash
lsblk -f
wipefs /dev/sda
wipefs /dev/sdb
```

---

## 7. Create ZFS Mirror

```bash
zpool create -f -o ashift=12 zfspool mirror /dev/sda /dev/sdb
```

* `zfspool` is the name of the ZFS pool
* `mirror /dev/sda /dev/sdb` sets up RAID1
* `ashift=12` optimizes for 4K sector drives
* `-f` forces creation (erases everything)

---

## 8. Verify ZFS Pool

```bash
zpool status
zpool list
zfs list
```

Example output:

```
  pool: zfspool
 state: ONLINE
config:

        NAME        STATE     READ WRITE CKSUM
        zfspool     ONLINE       0     0     0
          mirror-0  ONLINE       0     0     0
            sda     ONLINE       0     0     0
            sdb     ONLINE       0     0     0

errors: No known data errors

NAME      SIZE  ALLOC   FREE  CKPOINT  EXPANDSZ   FRAG    CAP  DEDUP    HEALTH  ALTROOT
zfspool  1.81T   420K  1.81T        -         -     0%     0%  1.00x    ONLINE  -

NAME      USED  AVAIL  REFER  MOUNTPOINT
zfspool   420K  1.76T    96K  /zfspool
```

---

## 9. Set Mountpoint for ZFS Pool

```bash
zfs set mountpoint=/mnt/zfsdata zfspool
```

* Now the pool is accessible at `/mnt/zfsdata`

---

## 10. Restore Backup Data

```bash
rsync -avh --progress /mnt/backup/ /mnt/zfsdata/
```

---

### ✅ Done!

* Fully mirrored ZFS RAID1 pool is created
* Ready to attach to Proxmox for VMs, containers, or backups
* Will be used for self-hosted services like NextCloud for photos and documents
