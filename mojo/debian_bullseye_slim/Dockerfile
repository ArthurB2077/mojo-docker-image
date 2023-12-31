FROM python:3.10.13-slim-bullseye as builder

ARG gpg_key_url=https://dl.modular.com/bBNWiLZX5igwHXeu/installer/gpg.0E4925737A3895AD.key
ARG installer_url=https://dl.modular.com/bBNWiLZX5igwHXeu/installer/config.deb.txt?distro=debian&codename=bullseye
ARG keyring_location=/usr/share/keyrings/modular-installer-archive-keyring.gpg
ARG default_user=mojo

RUN apt-get update && \
    apt-get install -y \
    apt-transport-https \
    wget \
    build-essential \
    curl \
    gnupg \
    libedit2 \
    python-is-python3 \
    llvm \
    && curl -1sLf ${gpg_key_url} | gpg --dearmor >> ${keyring_location} \
    && curl -1sLf ${installer_url} > /etc/apt/sources.list.d/modular-installer.list \
    && apt-get update \
    && apt-get install -y \
    modular \
    && rm -rf /var/lib/apt/lists/* \
    && groupadd -r ${default_user} \
    && useradd -r -g ${default_user} ${default_user} \
    && mkdir -p /home/${default_user} \
    && chown -R ${default_user}:${default_user} /home/${default_user} \
    && python -m pip install --upgrade pip

ENV MODULAR_HOME=/home/${default_user}/.modular
ENV PATH="$MODULAR_HOME/pkg/packages.modular.com_mojo/bin:$PATH"
ENV PATH="/home/mojo/.local/bin:$PATH"
ENV MOJO_PYTHON_LIBRARY=/usr/lib/x86_64-linux-gnu/libpython3.10.so.1
ENV LLVM_SYMBOLIZER_PATH=/usr/bin/llvm-symbolizer

WORKDIR /home/${default_user}

USER ${default_user}

RUN modular auth $keyring_location \
    && modular install mojo