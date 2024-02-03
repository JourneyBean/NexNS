# syntax=docker/dockerfile:1

FROM debian:bookworm

ENV LANG="C.UTF-8" \
    TZ=UTC \
    PUID=1000 \
    PGID=1000 \
    UMASK=022

WORKDIR /app


# copy dist files
ADD ./build/controller-docker/dist.tar /

RUN apt update && \
    apt-get install -y --no-install-recommends python3 nginx python3-pip python3-venv supervisor && \
    rm -rf /var/lib/apt/lists/* && \
    python3 -m venv /app/.venv && \
    /app/.venv/bin/pip3 install --no-cache-dir -r controller/requirements.txt && \
    /app/.venv/bin/pip3 install --no-cache-dir gunicorn && \
    chmod +x /app/entrypoint.sh

EXPOSE 80
VOLUME ["/data/config", "/data/data"]
ENTRYPOINT [ "/app/entrypoint.sh" ]
