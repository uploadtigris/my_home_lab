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
Unfortunately, the drives are formatted as NTFS which does not work well with Proxmox. So, I need to move the data from sdb to another drive so I can format these drives correctly.

Through some checking, found that sda is the drive with the items we would like to keep
```
mkdir -p /mnt/check
mount -t ntfs-3g /dev/sda2 /mnt/check
df -h /mnt/check
```
```
root@myhomelab:~# df -h /mnt/check
Filesystem      Size  Used Avail Use% Mounted on
/dev/sdb2       1.9T   58G  1.8T   4% /mnt/check
```
So, we prepare another drive `sdc` to copy the files to from sdb

## Backing up the data

```
# Make sure the drive is unmounted
umount /dev/sdc1

# Create a new ext4 filesystem
mkfs.ext4 -L BackupDrive /dev/sdc

# Create a mount point
mkdir -p /mnt/backup

# Mount it
mount /dev/sdc /mnt/backup

# Check free space
df -h /mnt/backup
```
```
df -h /mnt/backup
```
The drive is verified!

Now, we make sure that both drives are mounted
```
# mounting the drive to be copied over 
mkdir -p /mnt/check

# showing contents
df -h /mnt/check
ls -l /mnt/check

```
```
root@myhomelab:~# df -h /mnt/check
ls -l /mnt/check
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

# Copying files
`rsync -avh --progress /mnt/check/ /mnt/backup/`







