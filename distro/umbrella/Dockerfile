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
    # sudo git clone --recurse-submodules https://$(cat /run/secrets/GITHUB_USERNAME):$(cat /run/secrets/GITHUB_TOKEN)@github.com/LABSIM/UMBRELLA.git project/UMBRELLA \
    #
    # give all access to labsim
    #
    sudo chown -R $USERNAME /home/$USERNAME \
 && sudo chgrp -R $USERNAME /home/$USERNAME 

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
 && rm -rf $FSDI_DIST_VERSION.zip
ENV LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/home/$USERNAME/third_party/forceseat-di-$FSDI_VERSION/lib64


# #############################################
# #                                           #
# # SCHEME-GATEWAY-BUILD-LLVM-BOOKWORM        #
# #                                           #
# # ========================================= #
# # -> scheme-devcontainer-llvm-bookworm      #
# #############################################


# FROM scheme-gateway-devcontainer-llvm-bookworm AS scheme-gateway-build-llvm-bookworm

# # prettifyng
# LABEL description="SCHEME-GATEWAY build distro - Linux Debian 12 & LLVM 19.1.0" \
#       maintainer="nawfel.kinani@onera.fr" \
#       version="0.6.a" \
#       org.name="ONERA" \
#       org.department="DTIS" \
#       org.unit="ICNA" \
#       org.laboratory="LABSIM" \
#       org.center="Salon-de-Provence" \
#       license="GNU GPLv3"

# #
# # mandatory argument
# #
# ARG USERNAME=labsim

# #
# # default bash mode
# #
# SHELL ["/bin/bash", "-c"]

# #
# # setup default user
# #
# USER $USERNAME
# WORKDIR /home/$USERNAME/dev

# #
# # fully build the project SCHEME GATEWAY project container :
# # -> build & install OURANOS
# # -> build & install SCHEME-GATEWAY
# #
# RUN \
#     #
#     # source bashrc
#     #
#     source /home/$USERNAME/dev/titans/GAIA/script/GAIA.bashrc \
#     #
#     # configure, build & install OURANOS
#     #
#  && cd /home/$USERNAME/dev/titans/OURANOS \
#  && git pull \
#  && mkdir build \
#  && cd build \
#  && cmake -DLABSIM_INSTALL_PREFIX:PATH=/home/$USERNAME/prod .. \
#  && cmake --build . --target labsim-clean-deploy \
#     #
#     # configure, build & install SCHEME-GATEWAY
#     #
#  && cd /home/$USERNAME/dev/SCHEME-GATEWAY \
#  && git pull \
#  && mkdir build \
#  && cd build \
#  && cmake -DLABSIM_INSTALL_PREFIX:PATH=/home/$USERNAME/prod .. \
#  && cmake --build . --target labsim-clean-deploy \
#     #
#     # give all access to labsim
#     #
#  && sudo chown -R $USERNAME /home/$USERNAME/prod \
#  && sudo chgrp -R $USERNAME /home/$USERNAME/prod

 
# #############################################
# #                                           #
# # SCHEME-GATEWAY-PROD-LLVM-BOOKWORM         #
# #                                           #
# # ========================================= #
# # -> debian:bookworm-slim                   #
# #############################################


# FROM docker.io/debian:bookworm-slim AS scheme-gateway-prod-llvm-bookworm

# # prettifyng
# LABEL description="SCHEME-GATEWAY production distro - Linux Debian 12 & LLVM 19.1.0" \
#       maintainer="nawfel.kinani@onera.fr" \
#       version="0.6.a" \
#       org.name="ONERA" \
#       org.department="DTIS" \
#       org.unit="ICNA" \
#       org.laboratory="LABSIM" \
#       org.center="Salon-de-Provence" \
#       license="GNU GPLv3"

# #
# # mandatory argument : GAIA + user
# #
# ARG LLVM_VERSION=19
# ARG USERNAME=labsim
# ARG USER_UID=1000
# ARG USER_GID=$USER_UID
# ARG DEBIAN_FRONTEND=noninteractive

# RUN \
#     #
#     # create the labsim dev user
#     #
#     groupadd --gid $USER_GID $USERNAME \
#  && useradd --uid $USER_UID --gid $USER_GID --create-home --shell /bin/bash --no-log-init $USERNAME \
#     #
#     # repo installation specific tools
#     #
#  && apt-get --quiet update \
#  && apt-get install --quiet --no-install-recommends --assume-yes \
#     software-properties-common \
#     wget \
#     gpg \
#     locales \
#     perl \
#     #
#     # LLVM repo installation
#     # - see [https://apt.llvm.org/]
#     # add it twice to workaround:
#     # https://github.com/llvm/llvm-project/issues/62475
#     #
#  && wget -qO- https://apt.llvm.org/llvm-snapshot.gpg.key | tee /etc/apt/trusted.gpg.d/apt.llvm.org.asc \    
#  && add-apt-repository -y "deb http://apt.llvm.org/bookworm/  llvm-toolchain-bookworm-$LLVM_VERSION main" \
#  && add-apt-repository -y "deb http://apt.llvm.org/bookworm/  llvm-toolchain-bookworm-$LLVM_VERSION main" \
#     #
#     # refresh
#     #
#  && apt-get --quiet update \
#     #
#     # install specific tools - yes to every prompt - no recommmended quiet
#     #
#  && apt-get install --no-install-recommends --assume-yes \
#     # --> libc++
#     libc++-$LLVM_VERSION-dev \
#     libc++abi-$LLVM_VERSION-dev \
#     #
#     # apt cleanup
#     #
#  && apt-get autoremove --quiet --purge -y \
#  && apt-get clean --quiet \
#  && rm -rf /var/lib/apt/lists/* \
#     #
#     # then, setup locale
#     #
#  && locale-gen en_US.UTF-8 \
#  && localedef -i en_US -f UTF-8 en_US.UTF-8

# #
# # timezone & envs
# #
# ENV TZ=Europe/Paris \
#     LANGUAGE=en_US:en \
#     LC_ALL=en_US.UTF-8 \
#     LANG=en_US.UTF-8 \
#     LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/home/$USERNAME/third_party/ares-1.34.3/lib/:/home/$USERNAME/third_party/boost-1.86.0/lib/:/home/$USERNAME/third_party/openssl-3.4.0/lib/:/home/$USERNAME/third_party/perl-5.40.0/lib/:/home/$USERNAME/third_party/vrlink-5.9.1/lib64/:/home/$USERNAME/third_party/xerces-3.3.0/lib/\
#     PATH=$PATH:/home/$USERNAME/third_party/ares-1.34.3/bin/:/home/$USERNAME/third_party/openssl-3.4.0/bin/:/home/$USERNAME/third_party/perl-5.40.0/bin/:/home/$USERNAME/third_party/vrlink-5.9.1/bin64/\
#     LABSIM_VERBOSITY_LEVEL=DEBUG\
#     MAKLMGRD_LICENSE_FILE=@wlabsim0047s.scheme.labsim
# #
# # setup default user
# #
# USER $USERNAME
# WORKDIR /home/$USERNAME/prod/bin/Release

# #
# # inject prod env from build container
# #
# COPY \
#    --chown=$USERNAME:$USERNAME \
#    --from=scheme-gateway-build-llvm-bookworm \
#    /home/$USERNAME/.bashrc \
#    /home/$USERNAME/
# COPY \
#    --chown=$USERNAME:$USERNAME \
#    --from=scheme-gateway-build-llvm-bookworm \
#    /home/$USERNAME/perl5 \
#    /home/$USERNAME/perl5
# COPY \
#    --chown=$USERNAME:$USERNAME \
#    --from=scheme-gateway-build-llvm-bookworm \
#    --exclude=*/include \
#    --exclude=*/share \
#    --exclude=cmake* \
#    /home/$USERNAME/third_party \
#    /home/$USERNAME/third_party
# COPY \
#    --chown=$USERNAME:$USERNAME \
#    --from=scheme-gateway-build-llvm-bookworm \
#    --exclude=*/include \
#    --exclude=*ouranos/bin \
#    --exclude=*/bin/grpc* \
#    --exclude=*/bin/proto* \
#    --exclude=*/bin/tec \
#    --exclude=*/bin/Debug \
#    --exclude=*/lib/static/Debug \
#    /home/$USERNAME/prod \
#    /home/$USERNAME/prod
# COPY \
#    --chown=$USERNAME:$USERNAME \
#    --from=scheme-gateway-build-llvm-bookworm \
#    --exclude=*.git \
#    --exclude=*.git* \
#    --exclude=*.vscode \
#    /home/$USERNAME/dev/titans/GAIA \
#    /home/$USERNAME/prod/titans/gaia
