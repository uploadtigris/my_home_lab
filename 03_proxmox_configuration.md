# Proxmox Configuration

[Beginners Guide](https://www.youtube.com/watch?v=lFzWDJcRsqo&t=186s)

1. Reserve Proxmox IP in home router's DHCP settings
- enter IP + port address from Proxmox install into a browser's URL bar (i.e. https://192.168.0.1:####/ as appears on your GUI or terminal)
2. Use [Proxmox VE post-install script](https://community-scripts.github.io/ProxmoxVE/scripts?id=post-pve-install)
- MAKE SURE TO ALWAYS CHECK THE SOURCE OF SCRIPTS!!!
- running this script will install the no-subscription repository and do a myriad of other things
3. Connecting NAS Storage (this is for later)
Proxmox GUI (in browser) &rarr; Datacenter &rarr; Add: NFS

***jumping to another guide as the above one is not giving me the information I want***

-----------------

[Proxmox beginner tutorial](https://www.youtube.com/watch?v=d1UDj6eFXpQ)

1. pve &rarr; Disks &rarr; Initialize Disk with GPT (a disk that is not holding the proxmox OS)
2. Creating a ZFS (Zettabyte File System) partition on the auxialiary drive
   - Disks &rarr; ZFS &rarr; Create: ZFS
   - name: storaj
   - RAID Level: Single Disk
   - Compression: on
   - ashift: 12
   - Create 
     
   *BE AWARE of the warning message:* 
     >Note: ZFS is not compatible with disks backed by a hardware RAID controller. For details see the reference documentation.
3. 

