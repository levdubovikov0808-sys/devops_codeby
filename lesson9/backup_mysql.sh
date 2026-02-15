#!/bin/bash

BACKUP_DIR="/opt/mysql_backup"
DATE=$(date +%Y%m%d_%H%M%S)
DB_NAME="testdb"
BACKUP_FILE="$BACKUP_DIR/${DB_NAME}_$DATE.sql"
STORE_HOST="192.168.56.11"
STORE_USER="vagrant"
STORE_PASS="vagrant"
REMOTE_DIR="/opt/store/mysql"

mkdir -p "$BACKUP_DIR"

if ! mysqldump -u root "$DB_NAME" > "$BACKUP_FILE"; then
    echo "[$(date)] ERROR: Failed to create MySQL backup!" >&2
    exit 1
fi

echo "[$(date)] Backup created: $BACKUP_FILE"

if sshpass -p "$STORE_PASS" rsync -avz \
    -e "ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null" \
    "$BACKUP_FILE" "${STORE_USER}@${STORE_HOST}:${REMOTE_DIR}/"; then
    echo "[$(date)] Sync to store (${STORE_HOST}) successful"
else
    echo "[$(date)] ERROR: rsync to store FAILED!" >&2
    exit 1
fi

find "$BACKUP_DIR" -name "*.sql" -mtime +7 -delete

exit 0