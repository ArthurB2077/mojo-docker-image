FROM debian:bullseye-slim as builder_source

# Define ARG variables
ARG gpg_key_url=https://dl.modular.com/bBNWiLZX5igwHXeu/installer/gpg.0E4925737A3895AD.key
ARG installer_url=https://dl.modular.com/bBNWiLZX5igwHXeu/installer/config.deb.txt?distro=ubuntu&codename=jammy
ARG keyring_location=/usr/share/keyrings/modular-installer-archive-keyring.gpg

RUN apt-get update \
    && apt-get install -y \
    apt-transport-https \
    curl \
    gnupg \
    libc6-dev \
    && curl -1sLf ${gpg_key_url} | gpg --dearmor >> ${keyring_location} \
    && curl -1sLf ${installer_url} > /etc/apt/sources.list.d/modular-installer.list \
    && apt-get update \
    && apt-get install -y \
    modular \
    && rm -rf /var/lib/apt/lists/*

RUN ldd /usr/bin/modular


FROM alpine:3.18 as builder

ARG default_user=mojo
ARG keyring_location=/usr/share/keyrings/modular-installer-archive-keyring.gpg

# RUN apk add ca-certificates \
#     wget

# RUN wget -q -O /etc/apk/keys/sgerrand.rsa.pub https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub
# RUN wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.34-r0/glibc-2.34-r0.apk

# RUN apk add --allow-untrusted --force-overwrite glibc-2.34-r0.apk

ENV LD_LIBRARY_PATH=/lib:/usr/lib:/usr/local/lib

COPY --from=builder_source --chown=${default_user}:${default_user} /usr/bin/modular /usr/bin/modular
COPY --from=builder_source --chown=${default_user}:${default_user} /etc/modular /etc/modular
COPY --from=builder_source --chown=${default_user}:${default_user} /usr/share/man/man1/modular.1.gz /usr/share/man/man1/modular.1.gz
COPY --from=builder_source /usr/share/keyrings/modular-installer-archive-keyring.gpg /usr/share/keyrings/modular-installer-archive-keyring.gpg


RUN set -x \
    && apk upgrade --update-cache --available \
    && apk add --no-cache --update \
    build-base \
    cmake \
    g++ \
    gcc \
    gcompat \
    jpeg-dev \
    libc-dev \
    libc6-compat \
    libstdc++ \
    linux-headers \
    make \
    musl \
    ncurses \
    ncurses-libs \
    py-pip \
    python3-dev \
    zlib \
    zlib-dev \
    && addgroup -S ${default_user} \
    && adduser -S -G ${default_user} ${default_user} \
    && mkdir -p /home/${default_user} \
    && chown -R ${default_user}:${default_user} /home/${default_user}

# Set Environment Variables
ENV MODULAR_HOME=/home/${default_user}/.modular
ENV PATH="$MODULAR_HOME/pkg/packages.modular.com_mojo/bin:$PATH"
ENV PATH="/usr/bin:$PATH"

# Change Working Directory
WORKDIR /home/${default_user}

# Switch to user
USER ${default_user}

RUN modular auth $keyring_location \
    && modular install mojo

# NOT WORKING
