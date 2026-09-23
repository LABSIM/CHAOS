# syntax = docker/dockerfile:1.27.0


##################################
#                                #
#    UMBRELLA-BASE-GCC-TRIXIE    #
#                                #
# ============================== #
# -> Debian:trixie               #
#  -> buildpack-deps:trixie-curl #
#   -> buildpack-deps:trixie-scm #
#    -> buildpack-deps:trixie    #
#     -> gcc:16.2.0-trixie       #
##################################


FROM docker.io/gcc:16.2.0-trixie AS umbrella-base-gcc-trixie


# prettifyng
LABEL description="UMBRELLAbase distro - Linux Debian 13 & GNU GCC 16" \
      maintainer="nawfel.kinani@onera.fr" \
      version="0.1.a" \
      org.name="ONERA" \
      org.department="DTIS" \
      org.unit="ICNA" \
      org.laboratory="LABSIM" \
      org.center="Salon-de-Provence" \
      license="GNU GPLv3"
      
#
# avoid warnings by switching to noninteractive during build 
# --> ARG because it is not persisted in the final image vs. ENV
#
ARG DEBIAN_FRONTEND=noninteractive

#
# command
#
RUN set -ex \
	 #
    # refresh
 && apt-get --quiet update \
    #
    # install specific tools - yes to every prompt - no recommmended
    #
 && apt-get install --quiet --no-install-recommends --assume-yes \
    #
    # packages list
    #
    autoconf \
    autoconf-archive \
    automake \
    libtool \
    libtool-bin \
    build-essential \
    binutils-gold \
    zip \
    unzip \
    tar \
    gpg \
    apt-transport-https \
    locales \
    ccache \
    cmake \
    cmake-curses-gui \
    ninja-build \
    vim \
    man \
    gdb \
    valgrind \
    clang-tidy \
    clang-format \
    perl \
    cpanminus \
    doxygen \
    graphviz \
    python3-venv \
    python3-dev \
    libusb-1.0-0 \
    #
    # cleanup
    #
 && apt-get autoremove --purge -y \
 && apt-get clean \
 && apt-get dist-clean \
 && rm -rf /var/lib/apt/lists/* \
    #
    # then, setup locale
    #
 && locale-gen en_US.UTF-8 \
 && localedef -i en_US -f UTF-8 en_US.UTF-8

# timezone & env locales
ENV TZ=Europe/Paris \
    LANGUAGE=en_US:en \
    LC_ALL=en_US.UTF-8 \
    LANG=en_US.UTF-8 \
    CC=/usr/local/bin/gcc \
    CXX=/usr/local/bin/g++


####################################
#                                  #
# UMBRELLA-DEVCONTAINER-GCC-TRIXIE #
#                                  #
# ================================ #
# -> umbrella-base-gcc-trixie      #
####################################


FROM umbrella-base-gcc-trixie:latest AS umbrella-devcontainer-gcc-trixie

#
# mandatory arguments
#
ARG GAIA_TARGET_ECOSYSTEM="3.0.0"
ARG USERNAME=labsim
ARG USER_UID=1000
ARG USER_GID=$USER_UID
ARG FSDI_VERSION="2.191"
ARG FSDI_DIST_VERSION="ForceSeatDI_${FSDI_VERSION}_DLL"

#
# default shell mode
#
SHELL ["/bin/bash", "-c"]

#
# pre build
#
RUN \
    #
    # create the labsim dev user
    #
    groupadd --gid $USER_GID $USERNAME \
 && useradd --uid $USER_UID --gid $USER_GID --create-home --shell /bin/bash --no-log-init $USERNAME \
    #
    # add sudo support (Omit if you don't need to install software after connecting.)
    #
 && apt-get update \
 && apt-get install -y sudo \
 && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
 && chmod 0440 /etc/sudoers.d/$USERNAME \
    #
    # apt cleanup
    #
 && apt-get autoremove --quiet --purge -y \
 && apt-get clean --quiet \
 && rm -rf /var/lib/apt/lists/* 

#
# setup the UMBRELLA Ecosystem (SSE) : 
# -> default user
# -> default dev dir
# -> clone repos
# -> setup VSCode workspace
#
USER $USERNAME
WORKDIR /home/$USERNAME/dev
RUN \
    #
    # mount build secrets
    #
    --mount=type=secret,mode=0444,id=GITHUB_USERNAME,required=true \
    --mount=type=secret,mode=0444,id=GITHUB_TOKEN,required=true \
    #
    # clone LABSIM repositories
    #
    sudo git clone --recurse-submodules https://$(cat /run/secrets/GITHUB_USERNAME):$(cat /run/secrets/GITHUB_TOKEN)@github.com/LABSIM/GAIA.git titans/GAIA \
 && sudo git clone --recurse-submodules https://$(cat /run/secrets/GITHUB_USERNAME):$(cat /run/secrets/GITHUB_TOKEN)@github.com/LABSIM/OURANOS.git titans/OURANOS \
 && sudo git clone --recurse-submodules https://$(cat /run/secrets/GITHUB_USERNAME):$(cat /run/secrets/GITHUB_TOKEN)@github.com/LABSIM/UMBRELLA.git project/UMBRELLA \
    #
    # give all access to labsim
    #
 && sudo chown -R $USERNAME /home/$USERNAME \
 && sudo chgrp -R $USERNAME /home/$USERNAME \
   #
   # targeting LABSIM SSE through GAIA
   #
&& cd titans/GAIA/ecosystem/$GAIA_TARGET_ECOSYSTEM \
&& ./GAIA.sh


#
# inject the LABSIM SSE VSCode workspace
#
COPY --chown=$USERNAME:$USERNAME distro/umbrella/umbrella.code-workspace /home/$USERNAME/dev

#
# ForceSeat_MI specific
#
COPY --chown=$USERNAME:$USERNAME data/licensed/$FSDI_DIST_VERSION.zip /home/$USERNAME/third_party/
RUN \
    cd /home/$USERNAME/third_party \
 && unzip -a $FSDI_DIST_VERSION.zip -d forceseat-di-$FSDI_VERSION \
 && rm -rf $FSDI_DIST_VERSION.zip \
 && echo "export LD_LIBRARY_PATH=/home/$USERNAME/third_party/forceseat-di-$FSDI_VERSION${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}" >> ~/.bashrc \
 && ln -s /home/$USERNAME/third_party/forceseat-di-$FSDI_VERSION/ForceSeatDI64.LinuxPC.so /home/$USERNAME/third_party/forceseat-di-$FSDI_VERSION/ForceSeatDI64.so
