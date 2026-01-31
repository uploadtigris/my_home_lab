#!/bin/bash
# Update all systems

echo "Updating system packages..."
sudo dnf update -y

echo "Cleaning up old packages..."
sudo dnf autoremove -y

echo "Update complete!"
