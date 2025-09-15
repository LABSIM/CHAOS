# syntax = docker/dockerfile:1.4.3


####################################
#                                  #
#     LABSIM-BASE-GCC-BOOKWORM     #
#                                  #
# ================================ #
# -> Debian:bookworm               #
#  -> buildpack-deps:bookworm-curl #
#   -> buildpack-deps:bookworm-scm #
#    -> buildpack-deps:bookworm    #
#     -> gcc:14.1.0-bookworm       #
####################################


FROM docker.io/gcc:14.1.0-bookworm AS labsim-base-gcc-bookworm

# prettifyng
LABEL description="LABSIM base distro - Linux Debian 12 & GNU GCC 14.1.0" \
      maintainer="nawfel.kinani@onera.fr" \
      version="2.0.1" \
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
# update
#
RUN apt-get --quiet update \
    #
    # install specific tools - yes to every prompt - no recommmended
    #
 && apt-get install --quiet --no-install-recommends --assume-yes \
    #
    # generic package
    #
    apt-transport-https \
    autoconf \
    automake \
    bison \
    ccache \
    dpkg-dev \
    file \
    flex \
    gawk \
    gnupg2 \
    locales \
    libzstd-dev \
    libncurses-dev \
    libacl1-dev \
    make \
    patch \
    wget \
    zstd \
    #
    # GCC specific package
    # - default distro supplied GDB
    #
    gdb \
    #
    # cleanup
    #
 && apt-get autoremove --purge -y \
 && apt-get clean \
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
#    LABSIM-BASE-LLVM-BOOKWORM     #
#                                  #
# ================================ #
# -> Debian:bookworm               #
#  -> buildpack-deps:bookworm-curl #
#   -> buildpack-deps:bookworm-scm #
####################################


FROM docker.io/buildpack-deps:bookworm AS labsim-base-llvm-bookworm

# prettifyng
LABEL description="LABSIM base distro - Linux Debian 12 & LLVM 19.1.0" \
      maintainer="nawfel.kinani@onera.fr" \
      version="2.0.1" \
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
ARG LLVM_VERSION=21

#
# update
#
RUN \
    #
    # repo installation specific tools
    #
    apt-get --quiet update \
 && apt-get install --quiet --no-install-recommends --assume-yes \
    software-properties-common \
    wget \
    gpg \
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
    #
    # generic package
    #
    apt-transport-https \
    autoconf \
    automake \
    bison \
    ccache \
    dpkg-dev \
    file \
    flex \
    gawk \
    gnupg2 \
    libzstd-dev \
    libncurses-dev \
    libacl1-dev \
    locales \
    lsb-release \
    make \
    patch \
    zstd \
    #
    # LLVM specific dependancies
    # - cmake required by default
    # - ninja build strongly recommended
    #
    cmake \
    ninja-build \
    #
    # LLVM full packages
    # - see [https://apt.llvm.org/]
    #
    # LLVM
    libllvm-$LLVM_VERSION-ocaml-dev \
    libllvm$LLVM_VERSION \
    llvm-$LLVM_VERSION \
    llvm-$LLVM_VERSION-dev \
    llvm-$LLVM_VERSION-runtime \
    # Clang and co
    clang-$LLVM_VERSION \
    clang-tools-$LLVM_VERSION \
    libclang-common-$LLVM_VERSION-dev \
    libclang-$LLVM_VERSION-dev \
    libclang1-$LLVM_VERSION \
    clang-format-$LLVM_VERSION \
    python3-clang-$LLVM_VERSION \
    clangd-$LLVM_VERSION \
    clang-tidy-$LLVM_VERSION \
    # compiler-rt
    libclang-rt-$LLVM_VERSION-dev \
    # polly
    libpolly-$LLVM_VERSION-dev \
    # libfuzzer
    libfuzzer-$LLVM_VERSION-dev \
    # lldb
    lldb-$LLVM_VERSION \
    # lld (linker)
    lld-$LLVM_VERSION \
    # libc++
    libc++-$LLVM_VERSION-dev \
    libc++abi-$LLVM_VERSION-dev \
    # OpenMP
    libomp-$LLVM_VERSION-dev \
    # libclc
    libclc-$LLVM_VERSION-dev \
    # libunwind
    libunwind-$LLVM_VERSION-dev \
    # mlir
    libmlir-$LLVM_VERSION-dev \
    mlir-$LLVM_VERSION-tools \
    # bolt
    libbolt-$LLVM_VERSION-dev \
    bolt-$LLVM_VERSION \
    # flang
    flang-$LLVM_VERSION \
    # wasm support
    libclang-rt-$LLVM_VERSION-dev-wasm32 \
    libclang-rt-$LLVM_VERSION-dev-wasm64 \
    libc++-$LLVM_VERSION-dev-wasm32 \
    libc++abi-$LLVM_VERSION-dev-wasm32 \
    libclang-rt-$LLVM_VERSION-dev-wasm32 \
    libclang-rt-$LLVM_VERSION-dev-wasm64 \
    #
    # "install" into standard env
    #
 && for f in /usr/lib/llvm-$LLVM_VERSION/bin/*; do ln -sf "$f" /usr/local/bin; done \
    #
    # LLVM python installation
    # - see [https://github.com/llvm/llvm-project/issues/55575]
    #
 && mkdir -p /usr/lib/lib/python3.9/site-packages \
 && ln -s /usr/lib/llvm-$LLVM_VERSION/lib/python3.9/site-packages/lldb /usr/lib/lib/python3.9/site-packages/lldb \
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
 
# timezone & env locales
ENV TZ=Europe/Paris \
    LANGUAGE=en_US:en \
    LC_ALL=en_US.UTF-8 \
    LANG=en_US.UTF-8 \
    CC=/usr/local/bin/clang \
    CXX=/usr/local/bin/clang++ 
   #  CXXFLAGS="-stdlib=libc++" \
   #  LDFLAGS="-lc++ -lc++abi"


####################################
#                                  #
# LABSIM-DEVCONTAINER-GCC-BOOKWORM #
#                                  #
# ================================ #
# -> labsim-base-gcc-bookworm      #
####################################


# multi stage build
FROM labsim-base-gcc-bookworm AS labsim-devcontainer-gcc-bookworm

# prettifyng
LABEL description="LABSIM devcontainer distro - Linux Debian 12 & GNU GCC 14.1.0" \
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
ARG GAIA_TARGET_ECOSYSTEM="2.0.1"
ARG GAIA_ENABLE_FEATURE="dev,sb,sf"
ARG USERNAME=labsim
ARG USER_UID=1000
ARG USER_GID=$USER_UID

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
 && sudo git clone --recurse-submodules https://$(cat /run/secrets/GITHUB_USERNAME):$(cat /run/secrets/GITHUB_TOKEN)@github.com/LABSIM/THETYS.git titans/THETYS \
 && sudo git clone --recurse-submodules https://$(cat /run/secrets/GITHUB_USERNAME):$(cat /run/secrets/GITHUB_TOKEN)@github.com/LABSIM/OCEAN.git titans/OCEAN \
 && sudo git clone --recurse-submodules https://$(cat /run/secrets/GITHUB_USERNAME):$(cat /run/secrets/GITHUB_TOKEN)@github.com/LABSIM/RHEA.git titans/RHEA \
 && sudo git clone --recurse-submodules https://$(cat /run/secrets/GITHUB_USERNAME):$(cat /run/secrets/GITHUB_TOKEN)@github.com/LABSIM/KRONOS.git titans/KRONOS \
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
# finally, inject the LABSIM SSE VSCode workspace
#
COPY --chown=$USERNAME:$USERNAME distro/labsim/docker/labsim.code-workspace /home/$USERNAME/dev


#####################################
#                                   #
# LABSIM-DEVCONTAINER-LLVM-BOOKWORM #
#                                   #
# ================================= #
# -> labsim-base-llvm-bookworm      #
#####################################


# multi stage build
FROM labsim-base-llvm-bookworm AS labsim-devcontainer-llvm-bookworm

# prettifyng
LABEL description="LABSIM devcontainer distro - Linux Debian 12 & LLVM 19.1.0" \
      maintainer="nawfel.kinani@onera.fr" \
      version="2.0.1" \
      org.name="ONERA" \
      org.department="DTIS" \
      org.unit="ICNA" \
      org.laboratory="LABSIM" \
      org.center="Salon-de-Provence" \
      license="GNU GPLv3"

#
# mandatory argument : 
# - avoid warnings by switching to noninteractive during build
# - GAIA specific 
# - user name/UID/GUID
#
ARG DEBIAN_FRONTEND=noninteractive
ARG GAIA_TARGET_ECOSYSTEM="2.0.1" 
ARG GAIA_ENABLE_FEATURE="dev,sb,sf"
ARG USERNAME=labsim
ARG USER_UID=1000
ARG USER_GID=$USER_UID

#
# rootless mode
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
 && sudo git clone --recurse-submodules https://$(cat /run/secrets/GITHUB_USERNAME):$(cat /run/secrets/GITHUB_TOKEN)@github.com/LABSIM/THETYS.git titans/THETYS \
 && sudo git clone --recurse-submodules https://$(cat /run/secrets/GITHUB_USERNAME):$(cat /run/secrets/GITHUB_TOKEN)@github.com/LABSIM/OCEAN.git titans/OCEAN \
 && sudo git clone --recurse-submodules https://$(cat /run/secrets/GITHUB_USERNAME):$(cat /run/secrets/GITHUB_TOKEN)@github.com/LABSIM/RHEA.git titans/RHEA \
 && sudo git clone --recurse-submodules https://$(cat /run/secrets/GITHUB_USERNAME):$(cat /run/secrets/GITHUB_TOKEN)@github.com/LABSIM/KRONOS.git titans/KRONOS \
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
# finally, inject the LABSIM SSE VSCode workspace
#
COPY --chown=$USERNAME:$USERNAME distro/labsim/docker/labsim.code-workspace /home/$USERNAME/dev
