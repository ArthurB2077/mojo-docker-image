FROM debian:bullseye-slim as builder

ARG gpg_key_url=https://dl.modular.com/bBNWiLZX5igwHXeu/installer/gpg.0E4925737A3895AD.key
ARG installer_url=https://dl.modular.com/bBNWiLZX5igwHXeu/installer/config.deb.txt?distro=debian&codename=bullseye
ARG keyring_location=/usr/share/keyrings/modular-installer-archive-keyring.gpg
ARG default_user=mojo

RUN apt-get update && \
    apt-get install -y \
    apt-transport-https \
    wget \
    xz-utils \
    zlib1g-dev \
    build-essential

RUN apt-get remove -y python3 \
    && apt-get update \
    && wget -c https://www.python.org/ftp/python/3.10.0/Python-3.10.0.tar.xz \
    && tar -Jxvf Python-3.10.0.tar.xz \
    && cd Python-3.10.0 \
    && ./configure --enable-optimizations \
    && make altinstall \
    && update-alternatives --install /usr/bin/python python /usr/local/bin/python3.10 1 \
    && update-alternatives --install /usr/bin/python3 python3 /usr/local/bin/python3.10 1 \
    && update-alternatives --set python /usr/local/bin/python3.10 \
    && update-alternatives --install /usr/bin/pip pip /usr/local/bin/pip3.10 1 \
    && cd .. \
    && rm -rf Python-3.10.0.tar.xz Python-3.10.0

RUN apt-get update && \
    apt-get install -y \
    curl \
    gnupg \
    libedit2 \
    python-is-python3 \
    && curl -1sLf ${gpg_key_url} | gpg --dearmor >> ${keyring_location} \
    && curl -1sLf ${installer_url} > /etc/apt/sources.list.d/modular-installer.list \
    && apt-get update \
    && apt-get install -y \
    modular \
    && rm -rf /var/lib/apt/lists/* \
    && groupadd -r ${default_user} \
    && useradd -r -g ${default_user} ${default_user} \
    && mkdir -p /home/${default_user} \
    && chown -R ${default_user}:${default_user} /home/${default_user}

ENV MODULAR_HOME=/home/${default_user}/.modular
ENV PATH="$MODULAR_HOME/pkg/packages.modular.com_mojo/bin:$PATH"
ENV PATH="/home/mojo/.local/bin:$PATH"
ENV MOJO_PYTHON_LIBRARY=/usr/lib/x86_64-linux-gnu/libpython3.10.so.1.0

WORKDIR /home/${default_user}

USER ${default_user}

RUN modular auth $keyring_location \
    && modular install mojo