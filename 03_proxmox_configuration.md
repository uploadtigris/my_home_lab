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

   - It is best practice to install Proxmox on a different drive than the rest of the VMs. This is how I have this project set up.
3. Download an ISO
   - for my installation I will be using Debian, which you can find [here](https://www.debian.org/releases/)
   - we will need to find the architecture type of the computer. In the proxmox terminal enter the following command:
     
     <code>uname -m</code>
     
     if <code>x86_64</code> is returned, this means we have a 64-bit system \
     if <code>i686</code> is returned, this means we have a 32-bit system

     My system is a 64-bit system so I will navigate to: <code>[debian installation](https://www.debian.org/CD/)</code>

     I will go ahead with the Network Install @ [](https://www.debian.org/CD/netinst/)
     & **copy the link** for [this ISO network download for amd64 devices](https://cdimage.debian.org/debian-cd/current/amd64/iso-cd/debian-13.0.0-amd64-netinst.iso)

4. Install ISO in Proxmox
   - I am going to take the download link from the last step and insert @
  
     <code>pve &rarr; local (pve) &rarr; ISO Images &rarr; URL</code>

   ISO Configuration
   - I want to find out how many cores & sockets the device has. So, I will run:
  
     <code>lscpu</code>

     In my case we have a Intel(R) Core(TM) i7-4710MQ CPU @ 2.50GHz.
     - We get that my CPU has:
          - Threads per core: 2
          - Core per socket: 4
          - Sockets: 1 &rarr; this just means that there is only a single CPU in the device
     - This means that this CPU has 8 CPUs or 8 logical processors (as 4 cores X 2 threads = 8 processors)
     - So, we will distribute the resources as such: \
         Media Server: 2 cores, 1 socket \
         Storage Server: 3 cores, 1 socket \
         Network Services: 1 core, 1 socket 

         *They remaining cores will be used at a later date*

     

