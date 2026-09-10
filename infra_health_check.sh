#!/bin/bash

LOG_FILE="/home/trainee/web-stack/health_check.log"

echo "=== Infrastructure Health & Metrics Report: $(date) ===" >> "$LOG_FILE"

# Check Nginx status
if curl -s http://localhost/ | grep -q "Hello from DevOps Trainee Backend"; then
    echo "[PASS] Nginx proxy and Flask backend are responding correctly." >> "$LOG_FILE"
else
    echo "[FAIL] Nginx proxy or Flask backend is down." >> "$LOG_FILE"
fi

# Check Docker container running status
containers=("nginx_proxy" "flask_backend" "postgres_db")
for container in "${containers[@]}"; do
    if [ "$(docker inspect -f '{{.State.Running}}' "$container" 2>/dev/null)" == "true" ]; then
        echo "[PASS] Container $container is running." >> "$LOG_FILE"
    else
        echo "[FAIL] Container $container is NOT running." >> "$LOG_FILE"
    fi
done

# Basic System & Container Metrics
echo "--- System Resource Metrics ---" >> "$LOG_FILE"
echo "Disk Usage:" >> "$LOG_FILE"
df -h / | awk 'NR==1 || NR==2 {print $0}' >> "$LOG_FILE"

echo "Memory Usage:" >> "$LOG_FILE"
free -h >> "$LOG_FILE"

echo "Container Resource Utilization:" >> "$LOG_FILE"
docker stats --no-stream --format "table {{.Name}}\t{{.CPUPerc}}\t{{.MemUsage}}" >> "$LOG_FILE"
echo "" >> "$LOG_FILE"
