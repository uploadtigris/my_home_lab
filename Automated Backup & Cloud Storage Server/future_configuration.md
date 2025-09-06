# Self-Hosted Backup Server Setup Guide

## Service Overview

### Nextcloud
**Purpose**: Personal cloud storage and file synchronization
- Provides web-based file management interface
- Enables file sharing with users and external links
- Syncs files across multiple devices (desktop, mobile)
- Supports versioning and file recovery
- Can integrate with external storage backends
- **Use case**: Primary file storage, document collaboration, photo backup

### Duplicati
**Purpose**: Automated encrypted backup solution
- Creates incremental, encrypted backups to multiple destinations
- Supports cloud storage (Google Drive, AWS S3, etc.) and local targets
- Built-in deduplication and compression
- Web-based management interface
- Scheduled backup jobs with retention policies
- **Use case**: System backups, database backups, off-site backup automation

### Syncthing
**Purpose**: Peer-to-peer file synchronization
- Decentralized file sync without central server dependency
- Real-time bidirectional synchronization between devices
- No cloud storage required - direct device-to-device sync
- Conflict resolution and versioning
- End-to-end encryption
- **Use case**: Sync specific folders between devices, distributed backup copies

## Prerequisites
- Debian 13 Stable installed
- Minimum 2 drives (for RAID configuration)
- UPS for power protection
- Static IP or DDNS setup

## Hardware Setup

### Storage Configuration
```bash
# Check available drives
lsblk

# Set up RAID 1 (adjust device names as needed)
sudo mdadm --create --verbose /dev/md0 --level=1 --raid-devices=2 /dev/sdb /dev/sdc

# Create filesystem
sudo mkfs.ext4 /dev/md0

# Mount and configure auto-mount
sudo mkdir /mnt/storage
echo '/dev/md0 /mnt/storage ext4 defaults,nofail,discard 0 0' | sudo tee -a /etc/fstab
sudo mount -a
```

### System Hardening
```bash
# Update system
sudo apt update && sudo apt upgrade -y

# Configure firewall
sudo ufw enable
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw allow ssh
sudo ufw allow 8080  # Nextcloud
sudo ufw allow 8200  # Duplicati

# Disable root login
sudo sed -i 's/PermitRootLogin yes/PermitRootLogin no/' /etc/ssh/sshd_config
sudo systemctl restart sshd

# Install fail2ban
sudo apt install fail2ban -y
sudo systemctl enable fail2ban
```

## Application Installation

### Nextcloud
```bash
# Install dependencies
sudo apt install apache2 mariadb-server php php-mysql php-xml php-gd php-curl php-mbstring php-zip unzip -y

# Secure MariaDB
sudo mysql_secure_installation

# Create database
sudo mysql -u root -p
CREATE DATABASE nextcloud;
CREATE USER 'nextcloud'@'localhost' IDENTIFIED BY 'strong_password_here';
GRANT ALL PRIVILEGES ON nextcloud.* TO 'nextcloud'@'localhost';
FLUSH PRIVILEGES;
EXIT;

# Download and install Nextcloud
cd /tmp
wget https://download.nextcloud.com/server/releases/latest.tar.bz2
tar -xjf latest.tar.bz2
sudo mv nextcloud /var/www/html/
sudo chown -R www-data:www-data /var/www/html/nextcloud/
sudo chmod -R 755 /var/www/html/nextcloud/

# Configure Apache virtual host
sudo nano /etc/apache2/sites-available/nextcloud.conf
# Add Nextcloud configuration (see Nextcloud documentation)
sudo a2ensite nextcloud.conf
sudo a2enmod rewrite
sudo systemctl restart apache2
```

### Duplicati
```bash
# Install Mono
sudo apt install mono-complete -y

# Download and install Duplicati
wget https://updates.duplicati.com/beta/duplicati_2.0.6.3-1_all.deb
sudo dpkg -i duplicati_2.0.6.3-1_all.deb
sudo apt-get install -f  # Fix any dependency issues

# Create systemd service
sudo nano /etc/systemd/system/duplicati.service
```

Add to duplicati.service:
```ini
[Unit]
Description=Duplicati web-server
After=network.target

[Service]
Nice=19
IOSchedulingClass=3
EnvironmentFile=-/etc/default/duplicati
ExecStart=/usr/bin/duplicati-server $DAEMON_OPTS
Restart=always
User=duplicati
Group=duplicati

[Install]
WantedBy=multi-user.target
```

```bash
# Create duplicati user and enable service
sudo useradd -r -s /bin/false duplicati
sudo systemctl enable duplicati
sudo systemctl start duplicati
```

### Syncthing
```bash
# Add Syncthing repository
curl -s https://syncthing.net/release-key.txt | sudo apt-key add -
echo "deb https://apt.syncthing.net/ syncthing stable" | sudo tee /etc/apt/sources.list.d/syncthing.list

# Install Syncthing
sudo apt update
sudo apt install syncthing -y

# Enable for current user
systemctl --user enable syncthing
systemctl --user start syncthing
```

## Monitoring Setup

### System Monitoring
```bash
# Install monitoring tools
sudo apt install smartmontools htop iotop -y

# Configure SMART monitoring
sudo systemctl enable smartmontools
sudo nano /etc/smartd.conf
# Add: DEVICESCAN -a -o on -S on -n standby,q -s (S/../.././02|L/../../6/03) -W 4,35,40
sudo systemctl restart smartmontools

# Set up log rotation
sudo nano /etc/logrotate.d/backup-server
```

Add to logrotate config:
```
/var/log/duplicati/*.log {
    weekly
    rotate 4
    compress
    delaycompress
    missingok
    notifempty
    create 644 duplicati duplicati
}
```

### Email Alerts
```bash
# Install mail utilities
sudo apt install mailutils postfix -y

# Configure basic monitoring script
sudo nano /usr/local/bin/system-health-check.sh
sudo chmod +x /usr/local/bin/system-health-check.sh

# Add to crontab
sudo crontab -e
# Add: 0 6 * * * /usr/local/bin/system-health-check.sh
```

## Security Configuration

### SSL/TLS Setup
```bash
# Install Certbot for Let's Encrypt
sudo apt install certbot python3-certbot-apache -y

# Get SSL certificate (replace with your domain)
sudo certbot --apache -d your-domain.com

# Set up auto-renewal
sudo crontab -e
# Add: 0 12 * * * /usr/bin/certbot renew --quiet
```

### VPN Access (Optional)
```bash
# Install WireGuard
sudo apt install wireguard -y

# Generate keys
wg genkey | tee privatekey | wg pubkey > publickey

# Configure WireGuard (see WireGuard documentation for full setup)
```

## Backup Configuration

### Duplicati Setup
1. Access web interface at `http://your-server:8200`
2. Create backup jobs for critical data
3. Configure encryption with strong passphrase
4. Set up retention policies
5. Schedule regular backups

### 3-2-1 Backup Strategy
- **3 copies**: Original + 2 backups
- **2 media types**: Local RAID + external/cloud storage
- **1 offsite**: Cloud storage or remote location

## Maintenance Checklist

### Daily
- [ ] Check system status
- [ ] Verify backup jobs completed successfully
- [ ] Monitor disk space usage

### Weekly
- [ ] Test restore from recent backup
- [ ] Check SMART status of drives
- [ ] Review system logs

### Monthly
- [ ] Full system backup
- [ ] Update software packages
- [ ] Test disaster recovery procedures
- [ ] Review and rotate logs

### Quarterly
- [ ] Security audit
- [ ] Update documentation
- [ ] Test UPS functionality
- [ ] Review backup retention policies

## Troubleshooting

### Common Issues
- **Backup failures**: Check disk space, permissions, and network connectivity
- **Performance issues**: Monitor CPU, RAM, and I/O usage
- **RAID degradation**: Check `/proc/mdstat` and replace failed drives immediately

### Recovery Procedures
1. **System failure**: Boot from live USB, mount RAID array, restore from backup
2. **Drive failure**: Replace drive, rebuild RAID array
3. **Data corruption**: Restore from most recent verified backup

## Important Notes

- **Test restores regularly** - backups are worthless if you can't restore
- **Document everything** - keep configuration details and passwords secure
- **Monitor proactively** - set up alerts before problems become critical
- **Plan for growth** - consider future storage and bandwidth needs

## Useful Commands

```bash
# Check RAID status
cat /proc/mdstat

# Monitor disk usage
df -h

# Check system resources
htop

# View backup logs
sudo journalctl -u duplicati -f

# Test network connectivity
ping -c 4 8.8.8.8
```
