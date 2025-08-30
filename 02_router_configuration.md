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
Start IP Address: 192.168.0.### &rarr; network address; This is the first address in a subnet range. It typically represents the network address, which identifies the subnet itself. \
End IP Address: 192.168.0.### &rarr; broadcast address; This is the last address in the subnet range. It is often used as the broadcast address, which allows communication to all devices within that subnet. \
Lease Time: 120 minutes (default time) \
Default Gateway: \
Default Domain: \
DNS Server: 1.1.1.1 &rarr; (cloudflare);[why?](https://theispinfo.com/best-dns-settings-for-faster-internet/) \
Secondary DNS Server: 8.8.8.8 &rarr; (google) \
