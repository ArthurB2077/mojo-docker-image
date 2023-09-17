FROM ubuntu:jammy-20230816 as build

ARG gpg_key_url=https://dl.modular.com/bBNWiLZX5igwHXeu/installer/gpg.0E4925737A3895AD.key
ARG keyring_location=/usr/share/keyrings/modular-installer-archive-keyring.gpg
ARG installer_url=https://dl.modular.com/bBNWiLZX5igwHXeu/installer/config.deb.txt?distro=ubuntu&codename=jammy

RUN apt-get update && \
    apt-get install -y \
    apt-transport-https \
    curl \
    gnupg \
    && rm -rf /var/lib/apt/lists/*

RUN curl -1sLf ${gpg_key_url} | gpg --dearmor >> ${keyring_location}
RUN curl -1sLf ${installer_url} > /etc/apt/sources.list.d/modular-installer.list

RUN apt-get update && \
    apt-get install -y \
    modular

RUN modular auth $keyring_location

ENV MODULAR_HOME=/root/.modular
ENV PATH="$MODULAR_HOME/pkg/packages.modular.com_mojo/bin:$PATH"

RUN modular install mojo

RUN /bin/bash -c 'source $HOME/.bashrc && echo $(mojo --version)'
