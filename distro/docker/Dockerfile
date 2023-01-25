# syntax = docker/dockerfile:1.4.3


####################################
#                                  #
#     LABSIM-BASE-GCC-BULLSEYE     #
#                                  #
# ================================ #
# -> Debian:bullseye               #
#  -> buildpack-deps:bullseye-curl #
#   -> buildpack-deps:bullseye-scm #
#    -> buildpack-deps:bullseye    #
#     -> gcc:12.2.0-bullseye       #
####################################


FROM gcc:12.2.0-bullseye as labsim-base-gcc-bullseye

# prettifyng
LABEL description="LABSIM base distro - Linux Debian 11 & GNU GCC 12.2.0" \
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
LABEL description="LABSIM base distro - Linux Debian 11 & LLVM 15.0.7" \
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
    locales \
    libzstd-dev \
    libncurses-dev \
    libacl1-dev \
    make \
    patch \
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
    # set repository key
    # --> Fingerprint: 6084 F3CF 814B 57C1 CF12 EFD5 15CF 4D18 AF4F 7421
    #
 && wget -O - https://apt.llvm.org/llvm-snapshot.gpg.key | apt-key add - \
    #
    # install llvm toolchain from apt repos 
    # see [http://apt.llvm.org/]
    #
 && echo "deb http://apt.llvm.org/bullseye/ llvm-toolchain-bullseye-15 main" > /etc/apt/sources.list.d/llvm.list \
 #&& echo "deb-src http://apt.llvm.org/bullseye/ llvm-toolchain-bullseye-15 main" > /etc/apt/sources.list.d/llvm.list  \
 && apt-get --quiet update \
 && apt-get install --quiet --assume-yes -t llvm-toolchain-bullseye-15 \
    clang-15 \
    clangd-15 \
    clang-tidy-15 \
    clang-format-15 \
    clang-tools-15 \
    lldb-15 \
    lld-15 \
    libc++-15-dev \
    libc++abi-15-dev \
    #
    # "install" into standard env
    #
 && for f in /usr/lib/llvm-15/bin/*; do ln -sf "$f" /usr/local/bin; done \
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

# add & set labsim user
RUN useradd --create-home --user-group --shell /bin/bash --no-log-init labsim 
USER labsim


####################################
#                                  #
# LABSIM-DEVCONTAINER-GCC-BULLSEYE #
#                                  #
# ================================ #
# -> labsim-base-gcc-bullseye      #
####################################


# multi stage build
FROM labsim-base-gcc-bullseye as labsim-devcontainer-gcc-bullseye

# prettifyng
LABEL description="LABSIM devcontainer distro - Linux Debian 11 & GNU GCC 12.2.0" \
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
ARG GAIA_TARGET_ECOSYSTEM="LABSIM-2.0.0" \
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
LABEL description="LABSIM devcontainer distro - Linux Debian 11 & GNU GCC 12.2.0" \
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
ARG GAIA_TARGET_ECOSYSTEM="LABSIM-2.0.0" \
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

