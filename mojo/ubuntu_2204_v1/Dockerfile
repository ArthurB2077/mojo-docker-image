FROM ubuntu:22.04 as builder

ARG gpg_key_url=https://dl.modular.com/bBNWiLZX5igwHXeu/installer/gpg.0E4925737A3895AD.key
ARG installer_url=https://dl.modular.com/bBNWiLZX5igwHXeu/installer/config.deb.txt?distro=ubuntu&codename=jammy
ARG keyring_location=/usr/share/keyrings/modular-installer-archive-keyring.gpg
ARG default_user=mojo

RUN apt-get update && \
    apt-get install -y \
    apt-transport-https \
    python3

RUN python3 --version | grep -q 'Python 3.10' || (apt-get remove -y python3 && apt-get update && apt-get install -y python3.10)

RUN apt-get update && \
    apt-get install -y \
    curl \
    gnupg \
    libedit2 \
    python-is-python3 \
    python3.10-venv \
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