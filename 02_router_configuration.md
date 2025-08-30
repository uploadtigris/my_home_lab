# Router Configruation
## Device Specifications
Make &rarr; tp-link \
Model &rarr; [AC1200 Wireless Dual Band Router Model No. Archer A54](https://www.tp-link.com/us/home-networking/wifi-router/archer-a54/) \
Details &rarr; IPv6 Supported, 100 Mbps full duplex
## General
Operation Mode: Access Point &rarr; This allows for WiFi + ethernet access \
Wireless 2.4G &rarr; *disabled*; we do not have any devices that require 2.4G \
Wireless 5G &rarr; This will be the network we will be using
## Wireless 5G Setup
WPS &rarr; disabled; [known security vulnerabilities](https://www.howtogeek.com/176124/wi-fi-protected-setup-wps-is-insecure-heres-why-you-should-disable-it/) \
Wireless Security &rarr; WPA2 & AES Encryption
>WPA2-PSK (AES): This is the most secure option (outside of the newer WPA3.) It uses WPA2, the latest Wi-Fi encryption standard, and the latest AES encryption protocol. You should use this option unless your router supports WPA3---then use that instead. On some devices, you'll just see the option "WPA2" or "WPA2-PSK." If you do, it will probably just use AES, as that's a common-sense choice.

>Source: <i>[Wi-Fi Security: Should You Use WPA2-AES, WPA2-TKIP, or Both?](https://www.howtogeek.com/204697/wi-fi-security-should-you-use-wpa2-aes-wpa2-tkip-or-both/)</i>

## DHCP (Dynamic Host Configuration Protocol) Settings
DHCP Settings
- Start IP Address: 192.168.0.### &rarr; network address; This is the first address in a subnet range. It typically represents the network address, which identifies the subnet itself. \
- End IP Address: 192.168.0.### &rarr; broadcast address; This is the last address in the subnet range. It is often used as the broadcast address, which allows communication to all devices within that subnet. \
- Lease Time: 120 minutes (default time) \
- Default Gateway: 192.168.0.1 &rarr; This is the [IPv4 address of the device](https://www.youtube.com/watch?v=pCcJFdYNamc) connecting the LAN to the WAN\
- Default Domain: \
- DNS Server: 1.1.1.1 &rarr; (cloudflare);[why configure the DNS Server?](https://theispinfo.com/best-dns-settings-for-faster-internet/) \
- Secondary DNS Server: 8.8.8.8 &rarr; (google) \
  
Address Resevation
- I am reserving two IPv4 addresses: one for my laptop and one for my Proxmox server which will handle ingress traffic requests
- I am reseving these addresses to improve stability, ease of management, and the reduction of conflicts 
- I will also configure ARP Binding in the IP & MAC Binding section to reduce risks of [ARP spoofing attacks](https://www.geeksforgeeks.org/ethical-hacking/what-is-arp-spoofing-attack/)

## Forwarding
Virtual Server
Port Triggering
DMZ
UPnP

## Security
Advanced ~ DoS Protection
- Enable ICMP-Flood Attack Filtering @ 50 packets/second
- Enable UDP-Flood Attack Filtering @ 500 packets/second
- Enable TCP-SYN-Flood Attack Filtering @ 50 packets/second
- Forbid Pink Packet From WAN Port &rarr; This means that the subnet cannot be pinged without a VPN connection

## IP & MAC Binding
>ARP spoofing is a cyber attack that allows hackers to intercept communications between network devices on a network. Hackers can also use ARP spoofing to alter or block all traffic between devices on the network.
