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
            screen

COPY        entrypoint.sh /
EXPOSE      22
EXPOSE      443
EXPOSE      80
VOLUME      ["/etc/ssh","/data","/root","/sys/fs/cgroup"]
ENTRYPOINT  ["/entrypoint.sh"]