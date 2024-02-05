# Enable django debug feature or not
DEBUG = False

# Hostnames allowed
ALLOWED_HOSTS = [
    'localhost',
    '127.0.0.1',
    '::1',
]

# CORS settings
CORS_ORIGIN_ALLOW_ALL = True
CORS_ORIGIN_WHITELIST = [
    'http://localhost',
    'https://localhost',
]

# Database settings
# Use sqlite3 by default
# Change it to whatever database you like.
DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.sqlite3',
        'NAME':'/data/data/db.sqlite3',
    }
}

# Websocket settings
CHANNEL_LAYERS = {
    "default": {
        "BACKEND": "channels_redis.core.RedisChannelLayer",
        "CONFIG": {
            "hosts": ["redis://:!!!your_redis_password!!!@192.168.221.2:6379"],
        },
    },
}

# Whether enable email verification on user signup or not
# https://docs.allauth.org/en/latest/index.html
ACCOUNT_EMAIL_VERIFICATION = 'none'

# Configure social login if needed.
# https://docs.allauth.org/en/latest/index.html
SOCIALACCOUNT_PROVIDERS = {
    "openid_connect": {
        "APPS": [
            {
                "provider_id": "my_oidc_provider",
                ...
            },
        ]
    }
}
