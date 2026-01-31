#!/bin/bash
# Backup configuration files

BACKUP_DIR="${HOME}/backups/configs"
DATE=$(date +%Y%m%d_%H%M%S)

mkdir -p "${BACKUP_DIR}"

echo "Backing up configurations to ${BACKUP_DIR}/backup_${DATE}.tar.gz"

tar -czf "${BACKUP_DIR}/backup_${DATE}.tar.gz" \
    /etc/nginx/ \
    /etc/ssh/sshd_config \
    /etc/systemd/system/ \
    2>/dev/null

echo "Backup complete!"
