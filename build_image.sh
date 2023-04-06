#! /bin/bash
SUBVERSION=$1
SUBVERSION="${SUBVERSION:-0}"
export CURRENT_ALPINE_VERSION="$(w3m -dump https://alpinelinux.org/releases/ | grep "edge" -A1 | tail -1 | awk '{print $1}' | cut -d "v" -f 2)"
export OPENSSH_VERSION="$(w3m -dump "https://pkgs.alpinelinux.org/packages?name=openssh&branch=v${CURRENT_ALPINE_VERSION}" | grep -m 1 "x86" | awk '{print $2}')"
echo "Building Open-SSH in version '${OPENSSH_VERSION}' on Alpine '${CURRENT_ALPINE_VERSION}'"
docker build --build-arg OPENSSH_VERSION=${OPENSSH_VERSION} --build-arg ALPINE_VERSION=${CURRENT_ALPINE_VERSION} -t p3g4asus/alpine:${CURRENT_ALPINE_VERSION}.${SUBVERSION} -f- . < Dockerfile