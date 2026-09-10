#!/bin/bash

BACKUP_DIR="/var/backups/db"
# Ensure backup directory exists
sudo mkdir -p "$BACKUP_DIR"

# Dump PostgreSQL from container and compress
sudo docker exec -t postgres_db pg_dump -U trainee_user trainee_db | gzip > "$BACKUP_DIR/db_backup_$(date +%Y%m%d).sql.gz"


