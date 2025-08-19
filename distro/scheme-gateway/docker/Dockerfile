# syntax = docker/dockerfile:1.7-labs


#############################################
#                                           #
# SCHEME-GATEWAY-DEVCONTAINER-LLVM-BOOKWORM #
#                                           #
# ========================================= #
# -> labsim-base-llvm-bookworm              #
#############################################


FROM labsim-base-llvm-bookworm:2.0.1 AS scheme-gateway-devcontainer-llvm-bookworm

# prettifyng
LABEL description="SCHEME-GATEWAY devcontainer distro - Linux Debian 12 & LLVM 19.1.0" \
      maintainer="nawfel.kinani@onera.fr" \
      version="2.0.1" \
      org.name="ONERA" \
      org.department="DTIS" \
      org.unit="ICNA" \
      org.laboratory="LABSIM" \
      org.center="Salon-de-Provence" \
      license="GNU GPLv3"

#
# mandatory arguments
#
ARG GAIA_TARGET_ECOSYSTEM="2.0.1"
ARG GAIA_ENABLE_FEATURE="dev"
ARG USERNAME=labsim
ARG USER_UID=1000
ARG USER_GID=$USER_UID
ARG VRLINK_VERSION="5.9.1"
ARG VRLINK_DIST_VERSION="$VRLINK_VERSION-linux64-rhe8-20240920"

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
# setup the LABSIM Simulation Software Ecosystem (SSE) : 
# -> default user
# -> default dev dir
# -> clone repos
# -> integrate GAIA features 
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
 && sudo git clone --recurse-submodules https://$(cat /run/secrets/GITHUB_USERNAME):$(cat /run/secrets/GITHUB_TOKEN)@github.com/LABSIM/SCHEME-GATEWAY.git SCHEME-GATEWAY/ \
 && sudo git clone --recurse-submodules https://$(cat /run/secrets/GITHUB_USERNAME):$(cat /run/secrets/GITHUB_TOKEN)@github.com/LABSIM/SCHEME-GATEWAY-API.git SCHEME-GATEWAY-API \
 && sudo git clone --recurse-submodules https://$(cat /run/secrets/GITHUB_USERNAME):$(cat /run/secrets/GITHUB_TOKEN)@github.com/LABSIM/SCHEME-GATEWAY-DOC.git SCHEME-GATEWAY-DOC \
    #
    # give all access to labsim
    #
 && sudo chown -R $USERNAME /home/$USERNAME \
 && sudo chgrp -R $USERNAME /home/$USERNAME \
    #
    # bootstrap & run GAIA
    #
 && cd titans/GAIA \
 && /usr/bin/env bash GAIA-bootstrap --verbosity-level info --target-ecosystem ${GAIA_TARGET_ECOSYSTEM} --enable-feature ${GAIA_ENABLE_FEATURE}

#
# inject the LABSIM SSE VSCode workspace
#
COPY --chown=$USERNAME:$USERNAME distro/scheme-gateway/docker/scheme-gateway.code-workspace /home/$USERNAME/dev

#
# VRLink specific
#
COPY --chown=$USERNAME:$USERNAME data/licensed/vrLink$VRLINK_DIST_VERSION.tar.gz /home/$USERNAME/third_party
RUN \
    cd /home/$USERNAME/third_party \
 && tar -xzf vrLink$VRLINK_DIST_VERSION.tar.gz \
 && mv vrlink$VRLINK_VERSION vrlink-$VRLINK_VERSION \ 
 && rm -rf \
        vrlink-$VRLINK_VERSION/doc \
        vrlink-$VRLINK_VERSION/data \
        vrlink-$VRLINK_VERSION/examples \
        vrlink-$VRLINK_VERSION/java \
        vrlink-$VRLINK_VERSION/bin64 \
        vrLink$VRLINK_DIST_VERSION.tar.gz
ENV LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/home/$USERNAME/third_party/vrlink-$VRLINK_VERSION/lib64


#############################################
#                                           #
# SCHEME-GATEWAY-BUILD-LLVM-BOOKWORM        #
#                                           #
# ========================================= #
# -> scheme-devcontainer-llvm-bookworm      #
#############################################


FROM scheme-gateway-devcontainer-llvm-bookworm AS scheme-gateway-build-llvm-bookworm

# prettifyng
LABEL description="SCHEME-GATEWAY build distro - Linux Debian 12 & LLVM 19.1.0" \
      maintainer="nawfel.kinani@onera.fr" \
      version="2.0.1" \
      org.name="ONERA" \
      org.department="DTIS" \
      org.unit="ICNA" \
      org.laboratory="LABSIM" \
      org.center="Salon-de-Provence" \
      license="GNU GPLv3"

#
# mandatory argument
#
ARG USERNAME=labsim

#
# default bash mode
#
SHELL ["/bin/bash", "-c"]

#
# setup default user
#
USER $USERNAME
WORKDIR /home/$USERNAME/dev

#
# fully build the project SCHEME GATEWAY project container :
# -> build & install OURANOS
# -> build & install SCHEME-GATEWAY
#
RUN \
    #
    # source bashrc
    #
    source /home/$USERNAME/dev/titans/GAIA/script/GAIA.bashrc \
    #
    # configure, build & install OURANOS
    #
 && cd /home/$USERNAME/dev/titans/OURANOS \
 && git pull \
 && mkdir build \
 && cd build \
 && cmake -DLABSIM_INSTALL_PREFIX:PATH=/home/$USERNAME/prod .. \
 && cmake --build . --target labsim-clean-deploy \
    # ===================================================================================== << 
    # HACK ! switch SCHEME-GATEWAY-API to commit 0deb29b
    # ===================================================================================== << 
 && cd /home/$USERNAME/dev/SCHEME-GATEWAY-API \
 && git switch --detach 0deb29b \
    #
    # configure, build & install SCHEME-GATEWAY
    #
 && cd /home/$USERNAME/dev/SCHEME-GATEWAY \
 && git pull \
 && mkdir build \
 && cd build \
 && cmake -DLABSIM_INSTALL_PREFIX:PATH=/home/$USERNAME/prod .. \
 && cmake --build . --target labsim-clean-deploy \
    #
    # give all access to labsimx
    #
 && sudo chown -R $USERNAME /home/$USERNAME/prod \
 && sudo chgrp -R $USERNAME /home/$USERNAME/prod

 
#############################################
#                                           #
# SCHEME-GATEWAY-PROD-LLVM-BOOKWORM         #
#                                           #
# ========================================= #
# -> debian:bookworm-slim                   #
#############################################


FROM docker.io/debian:bookworm-slim AS scheme-gateway-prod-llvm-bookworm

# prettifyng
LABEL description="SCHEME-GATEWAY production distro - Linux Debian 12 & LLVM 19.1.0" \
      maintainer="nawfel.kinani@onera.fr" \
      version="2.0.1" \
      org.name="ONERA" \
      org.department="DTIS" \
      org.unit="ICNA" \
      org.laboratory="LABSIM" \
      org.center="Salon-de-Provence" \
      license="GNU GPLv3"

#
# mandatory argument : GAIA + user
#
ARG LLVM_VERSION=19
ARG USERNAME=labsim
ARG USER_UID=1000
ARG USER_GID=$USER_UID
ARG DEBIAN_FRONTEND=noninteractive

RUN \
    #
    # create the labsim dev user
    #
    groupadd --gid $USER_GID $USERNAME \
 && useradd --uid $USER_UID --gid $USER_GID --create-home --shell /bin/bash --no-log-init $USERNAME \
    #
    # repo installation specific tools
    #
 && apt-get --quiet update \
 && apt-get install --quiet --no-install-recommends --assume-yes \
    software-properties-common \
    wget \
    gpg \
    locales \
    perl \
    #
    # LLVM repo installation
    # - see [https://apt.llvm.org/]
    # add it twice to workaround:
    # https://github.com/llvm/llvm-project/issues/62475
    #
 && wget -qO- https://apt.llvm.org/llvm-snapshot.gpg.key | tee /etc/apt/trusted.gpg.d/apt.llvm.org.asc \    
 && add-apt-repository -y "deb http://apt.llvm.org/bookworm/  llvm-toolchain-bookworm-$LLVM_VERSION main" \
 && add-apt-repository -y "deb http://apt.llvm.org/bookworm/  llvm-toolchain-bookworm-$LLVM_VERSION main" \
    #
    # refresh
    #
 && apt-get --quiet update \
    #
    # install specific tools - yes to every prompt - no recommmended quiet
    #
 && apt-get install --no-install-recommends --assume-yes \
    # --> libc++
    libc++-$LLVM_VERSION-dev \
    libc++abi-$LLVM_VERSION-dev \
    #
    # apt cleanup
    #
 && apt-get autoremove --quiet --purge -y \
 && apt-get clean --quiet \
 && rm -rf /var/lib/apt/lists/* \
    #
    # then, setup locale
    #
 && locale-gen en_US.UTF-8 \
 && localedef -i en_US -f UTF-8 en_US.UTF-8

#
# timezone & envs
#
ENV TZ=Europe/Paris \
    LANGUAGE=en_US:en \
    LC_ALL=en_US.UTF-8 \
    LANG=en_US.UTF-8 \
    LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/home/$USERNAME/third_party/ares-1.34.3/lib/:/home/$USERNAME/third_party/boost-1.86.0/lib/:/home/$USERNAME/third_party/openssl-3.4.0/lib/:/home/$USERNAME/third_party/perl-5.40.0/lib/:/home/$USERNAME/third_party/vrlink-5.9.1/lib64/:/home/$USERNAME/third_party/xerces-3.3.0/lib/\
    PATH=$PATH:/home/$USERNAME/third_party/ares-1.34.3/bin/:/home/$USERNAME/third_party/openssl-3.4.0/bin/:/home/$USERNAME/third_party/perl-5.40.0/bin/:/home/$USERNAME/third_party/vrlink-5.9.1/bin64/\
    LABSIM_VERBOSITY_LEVEL=DEBUG
#
# setup default user
#
USER $USERNAME
WORKDIR /home/$USERNAME/prod/bin/Release

#
# inject prod env from build container
#
COPY \
   --chown=$USERNAME:$USERNAME \
   --from=scheme-gateway-build-llvm-bookworm \
   /home/$USERNAME/.bashrc \
   /home/$USERNAME/
COPY \
   --chown=$USERNAME:$USERNAME \
   --from=scheme-gateway-build-llvm-bookworm \
   /home/$USERNAME/perl5 \
   /home/$USERNAME/perl5
COPY \
   --chown=$USERNAME:$USERNAME \
   --from=scheme-gateway-build-llvm-bookworm \
   --exclude=*/include \
   --exclude=*/share \
   --exclude=cmake* \
   /home/$USERNAME/third_party \
   /home/$USERNAME/third_party
COPY \
   --chown=$USERNAME:$USERNAME \
   --from=scheme-gateway-build-llvm-bookworm \
   --exclude=*/include \
   --exclude=*ouranos/bin \
   --exclude=*/bin/grpc* \
   --exclude=*/bin/proto* \
   --exclude=*/bin/tec \
   --exclude=*/bin/Debug \
   --exclude=*/lib/static/Debug \
   /home/$USERNAME/prod \
   /home/$USERNAME/prod
COPY \
   --chown=$USERNAME:$USERNAME \
   --from=scheme-gateway-build-llvm-bookworm \
   --exclude=*.git \
   --exclude=*.git* \
   --exclude=*.vscode \
   /home/$USERNAME/dev/titans/GAIA \
   /home/$USERNAME/prod/titans/gaia
