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
#     -> gcc:13.1.0-bookworm       #
####################################


FROM gcc:13.1.0-bookworm as labsim-base-gcc-bookworm

# prettifyng
LABEL description="LABSIM base distro - Linux Debian 12 & GNU GCC 13.1.0" \
      maintainer="nawfel.kinani@onera.fr" \
      version="2.0.0" \
      org.name="ONERA" \
      org.department="DTIS" \
      org.unit="ICNA" \
      org.laboratory="LABSIM" \
      org.center="Salon-de-Provence" \
      license="GNU GPLv3"

# avoid warnings by switching to noninteractive during build 
# --> ARG because it is not persisted in the final image vs. ENV
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

# add & set labsim user
RUN useradd --create-home --user-group --shell /bin/bash --no-log-init labsim 
USER labsim

# check/install cpanm by default (sudoer...)
RUN sh -C 'if ! cpanm < /dev/null > /dev/null 2>&1 ; then curl -L http://cpanmin.us | perl - --sudo App::cpanminus; fi'


####################################
#                                  #
#    LABSIM-BASE-LLVM-BULLSEYE     #
#                                  #
# ================================ #
# -> Debian:bullseye               #
#  -> buildpack-deps:bullseye-curl #
#   -> buildpack-deps:bullseye-scm #
####################################


FROM buildpack-deps:bullseye as labsim-base-llvm-bullseye

# prettifyng
LABEL description="LABSIM base distro - Linux Debian 11 & LLVM 16.0.3" \
      maintainer="nawfel.kinani@onera.fr" \
      version="2.0.0" \
      org.name="ONERA" \
      org.department="DTIS" \
      org.unit="ICNA" \
      org.laboratory="LABSIM" \
      org.center="Salon-de-Provence" \
      license="GNU GPLv3"

# avoid warnings by switching to noninteractive during build 
# --> ARG because it is not persisted in the final image vs. ENV
ARG DEBIAN_FRONTEND=noninteractive

#
# LLVM version 
#
ARG LLVM_VERSION=16

#
# update
#
RUN apt-get --quiet update \
    #
    # install specific tools - yes to every prompt - no recommmended quiet
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
    libzstd-dev \
    libncurses-dev \
    libacl1-dev \
    locales \
    lsb-release \
    make \
    patch \
    software-properties-common \
    wget \
    zstd \
    #
    # LLVM specific package
    # - cmake required by default
    # - ninja build strongly recommended
    #
    cmake \
    ninja-build \
    #
    # LLVM installation
    # - see [https://apt.llvm.org/]
    #
 && wget -qO- https://apt.llvm.org/llvm-snapshot.gpg.key | tee /etc/apt/trusted.gpg.d/apt.llvm.org.asc \
 && add-apt-repository "deb http://apt.llvm.org/bullseye/ llvm-toolchain-bullseye-$LLVM_VERSION main" \
 && apt-get --quiet update \
 && apt-get install --quiet --no-install-recommends --assume-yes \
    llvm-$LLVM_VERSION-dev \
    llvm-$LLVM_VERSION-tools \
    lld-$LLVM_VERSION \
    lldb-$LLVM_VERSION \
    clang-$LLVM_VERSION \
    clangd-$LLVM_VERSION \
    clang-tidy-$LLVM_VERSION \
    clang-format-$LLVM_VERSION \
    clang-tools-$LLVM_VERSION \
    libomp-$LLVM_VERSION-dev \
    libc++-$LLVM_VERSION-dev \
    libc++abi-$LLVM_VERSION-dev \
    libclang-common-$LLVM_VERSION-dev \
    libclang-$LLVM_VERSION-dev \
    libclang-cpp$LLVM_VERSION-dev \
    libclang-rt-$LLVM_VERSION-dev \
    libunwind-$LLVM_VERSION-dev \
    libpolly-$LLVM_VERSION-dev \
    #
    # "install" into standard env
    #
 && for f in /usr/lib/llvm-16/bin/*; do ln -sf "$f" /usr/local/bin; done \
    #
    # LLVM python installation
    # - see [https://github.com/llvm/llvm-project/issues/55575]
    #
 && mkdir -p /usr/lib/lib/python3.9/site-packages \
 && ln -s /usr/lib/llvm-16/lib/python3.9/site-packages/lldb /usr/lib/lib/python3.9/site-packages/lldb \
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
    CXX=/usr/local/bin/clang++ \
    CXXFLAGS="-stdlib=libc++" \
    LDFLAGS="-lc++ -lc++abi"
    
# add & set labsim user
RUN useradd --create-home --user-group --shell /bin/bash --no-log-init labsim 
USER labsim

# check/install cpanm by default (sudoer...)
RUN sh -C 'if ! cpanm < /dev/null > /dev/null 2>&1 ; then curl -L http://cpanmin.us | perl - --sudo App::cpanminus; fi'


####################################
#                                  #
# LABSIM-DEVCONTAINER-GCC-BOOKWORM #
#                                  #
# ================================ #
# -> labsim-base-gcc-bookworm      #
####################################


# multi stage build
FROM labsim-base-gcc-bookworm as labsim-devcontainer-gcc-bookworm

# prettifyng
LABEL description="LABSIM devcontainer distro - Linux Debian 12 & GNU GCC 13.1.0" \
      maintainer="nawfel.kinani@onera.fr" \
      version="2.0.0" \
      org.name="ONERA" \
      org.department="DTIS" \
      org.unit="ICNA" \
      org.laboratory="LABSIM" \
      org.center="Salon-de-Provence" \
      license="GNU GPLv3"

# setup LABSIM Simulation Software Ecosysten : create dir, clone sources from github, then integrate gaia features & VSCode workspace
WORKDIR /home/labsim/dev

# mandatory GAIA argument
ARG GAIA_TARGET_ECOSYSTEM="2.0.0" \
    GAIA_ENABLE_FEATURE="dev,sb,sf"

#
# mount secrets, clone LABSIM repositories & bootstrap GAIA
#
RUN --mount=type=secret,mode=0444,id=GITHUB_USERNAME,required=true \
    --mount=type=secret,mode=0444,id=GITHUB_TOKEN,required=true \
    git clone https://$(cat /run/secrets/GITHUB_USERNAME):$(cat /run/secrets/GITHUB_TOKEN)@github.com/LABSIM/GAIA.git titans/GAIA \
 && git clone https://$(cat /run/secrets/GITHUB_USERNAME):$(cat /run/secrets/GITHUB_TOKEN)@github.com/LABSIM/OURANOS.git titans/OURANOS \
 && git clone --recurse-submodules https://$(cat /run/secrets/GITHUB_USERNAME):$(cat /run/secrets/GITHUB_TOKEN)@github.com/LABSIM/THETYS.git titans/THETYS \
 && git clone https://$(cat /run/secrets/GITHUB_USERNAME):$(cat /run/secrets/GITHUB_TOKEN)@github.com/LABSIM/OCEAN.git titans/OCEAN \
 && git clone https://$(cat /run/secrets/GITHUB_USERNAME):$(cat /run/secrets/GITHUB_TOKEN)@github.com/LABSIM/RHEA.git titans/RHEA \
 && git clone https://$(cat /run/secrets/GITHUB_USERNAME):$(cat /run/secrets/GITHUB_TOKEN)@github.com/LABSIM/KRONOS.git titans/KRONOS \
 && cd titans/GAIA \
 && chmod +x bootstrap-gaia.sh \
 && ./bootstrap-gaia.sh --verbosity-level info --target-ecosystem ${GAIA_TARGET_ECOSYSTEM} --enable-feature ${GAIA_ENABLE_FEATURE}
 
# inject the LABSIM SSE VSCode workspace
COPY --chown=labsim:labsim distro/docker/labsim.code-workspace .


#####################################
#                                   #
# LABSIM-DEVCONTAINER-LLVM-BULLSEYE #
#                                   #
# ================================= #
# -> labsim-base-llvm-bullseye      #
#####################################


# multi stage build
FROM labsim-base-llvm-bullseye as labsim-devcontainer-llvm-bullseye

# prettifyng
LABEL description="LABSIM devcontainer distro - Linux Debian 11 & LLVM 16.0.3" \
      maintainer="nawfel.kinani@onera.fr" \
      version="2.0.0" \
      org.name="ONERA" \
      org.department="DTIS" \
      org.unit="ICNA" \
      org.laboratory="LABSIM" \
      org.center="Salon-de-Provence" \
      license="GNU GPLv3"

# setup LABSIM Simulation Software Ecosysten : create dir, clone sources from github, then integrate gaia features & VSCode workspace
WORKDIR /home/labsim/dev

# mandatory GAIA argument
ARG GAIA_TARGET_ECOSYSTEM="2.0.0" \
    GAIA_ENABLE_FEATURE="dev,sb,sf"

#
# mount secrets, clone LABSIM repositories & bootstrap GAIA
#
RUN --mount=type=secret,mode=0444,id=GITHUB_USERNAME,required=true \
    --mount=type=secret,mode=0444,id=GITHUB_TOKEN,required=true \
    git clone https://$(cat /run/secrets/GITHUB_USERNAME):$(cat /run/secrets/GITHUB_TOKEN)@github.com/LABSIM/GAIA.git titans/GAIA \
 && git clone https://$(cat /run/secrets/GITHUB_USERNAME):$(cat /run/secrets/GITHUB_TOKEN)@github.com/LABSIM/OURANOS.git titans/OURANOS \
 && git clone --recurse-submodules https://$(cat /run/secrets/GITHUB_USERNAME):$(cat /run/secrets/GITHUB_TOKEN)@github.com/LABSIM/THETYS.git titans/THETYS \
 && git clone https://$(cat /run/secrets/GITHUB_USERNAME):$(cat /run/secrets/GITHUB_TOKEN)@github.com/LABSIM/OCEAN.git titans/OCEAN \
 && git clone https://$(cat /run/secrets/GITHUB_USERNAME):$(cat /run/secrets/GITHUB_TOKEN)@github.com/LABSIM/RHEA.git titans/RHEA \
 && git clone https://$(cat /run/secrets/GITHUB_USERNAME):$(cat /run/secrets/GITHUB_TOKEN)@github.com/LABSIM/KRONOS.git titans/KRONOS \
 && cd titans/GAIA \
 && chmod +x bootstrap-gaia.sh \
 && ./bootstrap-gaia.sh --verbosity-level info --target-ecosystem ${GAIA_TARGET_ECOSYSTEM} --enable-feature ${GAIA_ENABLE_FEATURE}
 
# inject the LABSIM SSE VSCode workspace
COPY --chown=labsim:labsim distro/docker/labsim.code-workspace .

