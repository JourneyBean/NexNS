# 部署控制器

## 容器部署

::: info
默认镜像未包含 redis，所以在使用时请确保能使用外部 redis。当然，如果你使用示例提供的 `docker-compose.yml` ，则默认配置了 redis 服务。

控制端依赖消息来通知服务器热重载域名，而这一过程依赖 redis。因此如果 redis 不通，会导致服务端无法热重载。

当然，如果你想配置不同的消息协议，可以转到下一小节查看 CHANNELS 的配置。
:::

::: info
默认镜像使用 sqlite3 数据库。如果你需要更好的性能，可能需要修改 `docker-compose.yml` ，并参考下一小节来配置数据库。
:::

### 容器内部信息

如果你是容器大师，阅读这一小点就够了。

绑定卷：

- ro, /data/config - 配置目录
    - ro, /data/config/nginx.conf - Nginx 配置文件
    - ro, /data/config/settings.py - 自定义 django 参数配置
    - ro, /data/config/initialize (尚无作用，打算用于标识是否初始化)
- rw, /data/data - 数据目录
    - rw, /data/data/log - 日志
        - rw, /data/data/log/nginx - Nginx 日志
        - rw, /data/data/log/controller-wsgi - WSGI 日志
        - rw, /data/data/log/controller-asgi - ASGI 日志
    - rw, /data/data/db.sqlite3 - 数据库文件（如果使用默认数据库配置）

网络端口：

- 0.0.0.0:80 - HTTP 服务端口
- [::]:80 - HTTP 服务端口（IPv6）

### 简明教程

首先，选择一个钟意的文件夹来保存配置文件，简单起见，这里我们使用 /opt/nexns 文件夹来保存所有配置文件和日志文件。然后将示例配置文件复制到文件夹中。

``` bash
cd
git clone https://github.com/JourneyBean/NexNS
sudo mkdir -p /opt/nexns
sudo cp NexNS/example-config/controller-docker-compose/* /opt/nexns/
sudo cd /opt/nexns
sudo chown -R root:root ./*
```

现在建议修改一下配置文件，至少把 redis 密码改一下，可参考 [服务访问配置](/zh/deploy/controller/config/backend) 小节。

修改完成后，启动即可：

``` bash
sudo docker-compose up -d
```

## 源码部署

待补充

## 手动添加客户端

目前还不支持在 WebUI 添加客户端，请在容器内执行命令添加。

``` bash
docker exec -it 1a2b3c bash
root@1a2b3c:/app# source /app/.venv/bin/activate
(.venv) root@1a2b3c:/app# cd /app/controller/
(.venv) root@1a2b3c:/app/controller# python ./manage.py add_client
```

## 手动添加用户 API Key

目前还不支持在 WebUI 添加用户的 API Key，请在容器内执行命令添加。

``` bash
docker exec -it 1a2b3c bash
root@1a2b3c:/app# source /app/.venv/bin/activate
(.venv) root@1a2b3c:/app# cd /app/controller/
(.venv) root@1a2b3c:/app/controller# python ./manage.py add_apikey
```
