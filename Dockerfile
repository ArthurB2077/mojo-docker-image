FROM ubuntu:jammy-20230816 as os-build-stage

ENV MODULAR_URL=https://get.modular.com
ENV KEYRING_LOCATION=/usr/share/keyrings/modular-installer-archive-keyring.gpg
ENV HOME=/root
ENV MODULAR_HOME="$HOME/.modular"

RUN apt-get update
RUN apt-get install -y apt-transport-https curl gnupg

RUN curl -1sLf 'https://dl.modular.com/bBNWiLZX5igwHXeu/installer/gpg.0E4925737A3895AD.key' | gpg --dearmor >> ${KEYRING_LOCATION}
RUN curl -1sLf 'https://dl.modular.com/bBNWiLZX5igwHXeu/installer/config.deb.txt?distro=ubuntu&codename=jammy' > /etc/apt/sources.list.d/modular-installer.list

RUN apt-get update

RUN apt-get install -y modular
RUN modular auth $KEYRING_LOCATION

ENV MODULAR_HOME="$HOME/.modular"
ENV PATH="$MODULAR_HOME/pkg/packages.modular.com_mojo/bin:$PATH"

RUN modular install mojo