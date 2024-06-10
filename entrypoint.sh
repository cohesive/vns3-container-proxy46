#!/bin/bash
set -e

# Create necessary directories
mkdir -p /mnt/logs/plugins/proxy46

# Execute supervisord as PID 1
exec /usr/bin/supervisord -c /etc/supervisor/supervisord.conf
