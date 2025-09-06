### Nextcloud
**Purpose**: Personal cloud storage and file synchronization
- Provides web-based file management interface
- Enables file sharing with users and external links
- Syncs files across multiple devices (desktop, mobile)
- Supports versioning and file recovery
- Can integrate with external storage backends
- **Use case**: Primary file storage, document collaboration, photo backup

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
