# 服务配置

本节介绍如何配置控制器服务。如数据库连接、身份认证等。

## 域名白名单配置

使用白名单内的域名才可访问控制器提供的 API。

编辑 `config/settings.py`

``` python
ALLOWED_HOSTS = [
    'localhost',
    '127.0.0.1',
    '::1',
]
CORS_ORIGIN_ALLOW_ALL = True
CORS_ORIGIN_WHITELIST = [
    'http://localhost',
    'https://localhost',
]
```

## 数据库配置

编辑 `config/settings.py`

默认配置使用 sqlite3，配置如下：

``` python
DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.sqlite3',
        'NAME': '/data/data/db.sqlite3',
    }
}
```

如果需要连接使用外部数据库，如 postgresql，可以修改如下：

``` python
DATABASES = {
    "default": {
        "ENGINE": "django.db.backends.postgresql",
        "NAME": "mydatabase",
        "USER": "mydatabaseuser",
        "PASSWORD": "mypassword",
        "HOST": "127.0.0.1",
        "PORT": "5432",
    }
}
```

::: tip
如果需要连接到其他类型的数据库，请参考 [Django文档 - 数据库](https://docs.djangoproject.com/en/5.0/ref/databases/)
:::

## 缓存服务配置

需要使用类似于 Redis 的缓存服务，控制器才能成功通知服务器重新加载域名。

编辑 `config/settings.py`

默认配置使用 redis，配置如下：

``` python
CHANNEL_LAYERS = {
    "default": {
        "BACKEND": "channels_redis.core.RedisChannelLayer",
        "CONFIG": {
            "hosts": ["redis://:!!!your_redis_password!!!@192.168.221.2:6379"],
        },
    },
}
```

::: tip
如果你需要使用其他服务，可以参考 [Channels 文档 - Channel Layers](https://channels.readthedocs.io/en/latest/topics/channel_layers.html)。但是请注意，对于 docker 镜像版本，仅支持使用 redis。
:::

## 用户认证

控制器采用 `allauth` 提供登录/注册功能。

### 禁用注册电子邮件认证

默认在用户注册时，需要验证电子邮件。

编辑 `config/settings.py`

```
ACCOUNT_EMAIL_VERIFICATION = 'none'
```

### 登录提供商

如果需要使用其他登录提供商（通过 GtLab/GitHub/Google 等方式登录），示例：

编辑 `config/settings.py`

``` python
SOCIALACCOUNT_PROVIDERS = {
    "gitlab": {
        "SCOPE": ["api"],
        "APPS": [
            {
                "client_id": "<insert-id>",
                "secret": "<insert-secret>",
                "settings": {
                    "gitlab_url": "https://your.gitlab.server.tld",
                }
            }
        ]
    },
}
```

::: tip
可参考 [django-allauth 文档 - Providers](https://docs.allauth.org/en/latest/socialaccount/providers/index.html) 查看所有支持的提供商。
:::

### 禁用注册

allauth 并不支持禁用注册功能。因此请在 nginx 配置中禁用：

编辑 `config/nginx.conf`

``` conf
server {
    ...

    # disable signup
    location /accounts/signup {
        rewrite ^/(.*) /accounts/login/ redirect;
    }

    ...
}
    
```

注意这同样阻止从其他登录提供商登录新用户。

如果只是想禁用账号/密码注册方式，而允许通过提供商注册用户，请继续添加以下配置：

编辑 `config/settings.py`

``` python
SOCIALACCOUNT_AUTO_SIGNUP = True
```
