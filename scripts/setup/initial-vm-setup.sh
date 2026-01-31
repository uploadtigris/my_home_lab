#!/bin/bash
# Initial VM setup script

set -e

echo "Starting initial VM setup..."

# Update system
echo "Updating system packages..."
sudo dnf update -y

# Install basic tools
echo "Installing basic tools..."
sudo dnf install -y vim git htop curl wget

# Set timezone
echo "Setting timezone..."
sudo timedatectl set-timezone America/Chicago

# Enable firewall
echo "Enabling firewall..."
sudo systemctl enable --now firewalld

echo "Initial setup complete!"
