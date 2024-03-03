# Web 服务配置

编辑 `config/nginx.conf`，默认配置如下：

``` conf
upstream nexns-wsgi {
    server unix:/var/run/nexns/wsgi.sock;
}

upstream nexns-asgi {
    server unix:/var/run/nexns/asgi.sock;
}

map $http_upgrade $connection_upgrade {
    default upgrade;
    '' close;
}

server {
    server_name _;

    listen 80 default_server;
    listen [::]:80 default_server;

    access_log /data/data/log/nginx/access.log;
    error_log /data/data/log/nginx/error.log;

    location /api {
        proxy_pass http://nexns-wsgi;
        proxy_buffering off;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-Host $host;
        proxy_set_header Host $http_host;
        proxy_set_header X-Forwarded-Port $server_port;
    }

    location /api/v1/ws {
        proxy_pass http://nexns-asgi;
        proxy_buffering off;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-Host $host;
        proxy_set_header Host $http_host;
        proxy_set_header X-Forwarded-Port $server_port;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection $connection_upgrade;
    }

    location /account {
        proxy_pass http://nexns-wsgi;
        proxy_buffering off;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-Host $host;
        proxy_set_header Host $http_host;
        proxy_set_header X-Forwarded-Port $server_port;
    }

    location / {
        root /app/webui;
        try_files $uri $uri/ $uri.html /index.html;
    }
}
```

你可以自由修改该文件，包括进行 SSl、反向代理等配置的调整。这里不做多讲解。
