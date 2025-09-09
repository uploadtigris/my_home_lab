### Nextcloud
**Purpose**: Personal cloud storage and file synchronization
- Provides web-based file management interface
- Enables file sharing with users and external links
- Syncs files across multiple devices (desktop, mobile)
- Supports versioning and file recovery
- Can integrate with external storage backends
- **Use case**: Primary file storage, document collaboration, photo backup

### SSH Access
1. Access the VM via ```ssh username_on_VM@IPv4_adress```
2. to get admin powers type ```sudo -i```
3. To make the ssh name shorter like ```tigris@storage```:
       - ```sudo nano /etc/hosts``` \
       - add this line at the bottom of the file ~>```{your ipv4 address} {name you want}``` ~> press ctrl+x, y, enter\
       - ```ssh user@chosen_name```

### System Hardening
```bash
# Update system
sudo apt update && sudo apt upgrade -y

# Configure firewall (UFW: Uncomplicated Firewall)
sudo apt install ufw -y
sudo ufw enable
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw allow ssh
sudo ufw allow 80   # HTTP
sudo ufw allow 443  # HTTPS

# Disable root login
sudo sed -i 's/PermitRootLogin yes/PermitRootLogin no/' /etc/ssh/sshd_config
sudo systemctl restart sshd

# Install fail2ban (intrusion prevention software designed to protect servers from brute-force attacks)
sudo apt install fail2ban -y
sudo systemctl enable fail2ban
sudo systemctl start fail2ban
```

### Nextcloud
```bash
# Install dependencies
sudo apt install apache2 mariadb-server libapache2-mod-php \
php php-mysql php-xml php-gd php-curl php-mbstring php-zip php-intl \
php-bcmath php-gmp unzip wget -y

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
```
Paste this in
```
<VirtualHost *:80>
    ServerAdmin admin@example.com
    DocumentRoot /var/www/html/nextcloud
    ServerName yourdomain.com

    <Directory /var/www/html/nextcloud/>
        Options +FollowSymlinks
        AllowOverride All
        Require all granted
    </Directory>

    ErrorLog ${APACHE_LOG_DIR}/nextcloud_error.log
    CustomLog ${APACHE_LOG_DIR}/nextcloud_access.log combined
</VirtualHost>
```
``` bash
# Add Nextcloud configuration ; Enable site + required Apache modules:
sudo a2ensite nextcloud.conf
sudo a2enmod rewrite headers env dir mime
sudo systemctl restart apache2
```

### Confirmation

Check Status
```
sudo systemctl status apache2
```
Confirm Nextcloud files exist
```
ls -l /var/www/html/nextcloud
```

# TODO: Link the IP to a outward facing domain so that I can access it from outside the house

