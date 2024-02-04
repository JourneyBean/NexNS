#!/bin/bash

# nginx.conf
if [ -f /data/config/nginx.conf ]; then
    cp /data/config/nginx.conf /etc/nginx/sites-enabled/default
fi

nginx -t

# settings.py
if [ -f /data/config/settings.py ]; then
    cp /data/config/settings.py /app/controller/main/nexns_settings.py
fi

# initialize
mkdir -p /var/nexns
if [ -f /data/config/initialize ]; then
    cp /data/config/initialize /var/nexns/initialize
fi

# make run dir
mkdir -p /var/run/nexns
chown www-data:www-data /var/run/nexns

# /data/data permission
chown -R www-data:www-data /data/data

# make log dir
mkdir -p /data/data/log
mkdir -p /data/data/log/nginx
mkdir -p /data/data/log/controller-wsgi
mkdir -p /data/data/log/controller-asgi

# venv
source /app/.venv/bin/activate

cd /app/controller

# migrate the database
python3 manage.py migrate

# set database permission if created (only for sqlite)
chown www-data:www-data /data/data/db.sqlite3

# Start Supervisor
supervisord -c /etc/supervisor/supervisord.conf

# Start Nginx
nginx -g "daemon off;"
