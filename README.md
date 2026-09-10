# DevOps Stack & Deployment Project

## 1. Architecture Overview
This project deploys a multi-container web application stack using Docker and Docker Compose.

### Stack Components:
- **Nginx Proxy (`nginx_proxy`)**: Acts as the reverse proxy, routing incoming HTTP traffic on port 80 to the backend application.
- **Flask Backend (`flask_backend`)**: Python/Flask application running on port 5000, serving API/web responses.
- **PostgreSQL Database (`postgres_db`)**: Relational database running on port 5432 with persistent volume storage.
- **Jenkins (`jenkins`)**: Self-hosted CI/CD automation server.

---

## 2. Backup & Disaster Recovery
Automated database backups are configured via a shell script stored in the project directory.

- **Backup Script (`db_backup.sh`)**: Executes a `pg_dump` inside the PostgreSQL container, compresses the file using `gzip`, and stores it with a timestamp.
  - **Storage Path**: `/var/backups/db/`
  - **Naming Convention**: `db_backup_YYYYMMDD.sql.gz`

### Restoration Workflow:
To restore the database from a backup archive, run:
```bash
gunzip -c /var/backups/db/db_backup_YYYYMMDD.sql.gz | docker exec -i postgres_db psql -U trainee_user -d trainee_db
