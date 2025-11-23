#Pi-hole

[Reference](https://www.raspberrypi.com/tutorials/running-pi-hole-on-a-raspberry-pi/)

- Pi-hole is a piece of software that runs on a raspberry pi which acts as a "DNS Sinkhole". 
- Pi-hole sits between you and the DNS server. When you search "google.com", Pi-hole checks if google.com is on a block list, then it queries a real DNS server for the correct IP address.

Updating the device & installing the Raspberry Pi imager
```
sudo apt update
sudo apt install rpi-imager
```
Opening the imager
```
rpi-imager
```
Entering settings into the imager:

Device: Raspberry Pi 2 Model B 

OS: Raspberry Pi OS Lite (32-bit) ~ [A port of Debian Trixie with no desktop environment]

Found where the system was mounted (on a Ubuntu linux desktop)
```
# it was in "bootfs"
ls /media/tigris/
```
```
# Create the ssh file
touch /media/tigris/bootfs/ssh
```
safely eject MicroSD
```
#both bootfs and rootfs showed up for me
sudo umount /media/tigris/bootfs
sudo umount /media/tigris/rootfs
```
Scanned network for available connections (looking for Raspberry Pi)
```
sudo nmap -sn 192.168.1.0/24
# The Pi showed up as "Rivet Networks"
```
ssh'd into the Pi
```
ssh username@192.168.1.x
# entered password
```
Installed Pi-Hole
```
curl -sSL https://install.pi-hole.net | bash
```
Walked through the automated installer

Manually set Static IP Addresses
```
sudo nmcli connection modify "Wired connection 1" ipv4.addresses 192.168.1.224/24 ipv4.gateway 192.168.1.1 ipv4.dns "8.8.8.8,8.8.4.4" ipv4.method manual
sudo nmcli connection down "Wired connection 1" && sudo nmcli connection up "Wired connection 1"
```
Set DNS to Cloudflare

Used default block list of StevelBlack's Unified Hosts List

Enabled query logging

(0) - Show Everything. 

Set password via SSH
```
sudo pihole setpassword
```

Set Pi's IP as my DNS server & logged into the Pi-hole admin console

WORKS!





