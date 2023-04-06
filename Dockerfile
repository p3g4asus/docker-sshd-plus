FROM  hermsi/alpine-sshd:latest

RUN echo "" >> /etc/apk/repositories \
    && \
    echo "@testing http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories \
    && \
    mkdir -p /data \
    mkdir -p /root \
    && \
    apk add --no-cache \
            git \
            nginx \
            redis \
            mosquitto \
            dhcp \
            openrc \
            openssl \
            ddclient@testing \
            screen \
            acf-alpine-conf \
            acf-core \
            acf-dhcp \
            acf-openvpn \
            acf-db \
            lua-sql-sqlite3 \
            alpine-conf \
    && \
    setup-acf
ENV         ACME_EMAIL=""
ENV         START_PARAM=0
ENV         POST_EXEC=""
ENV         ROOT_PASSWORD=""
COPY        entrypoint.sh /
EXPOSE      22
EXPOSE      443
EXPOSE      80
VOLUME      ["/etc/ssh","/data","/root","/sys/fs/cgroup"]
ENTRYPOINT  ["/entrypoint.sh"]