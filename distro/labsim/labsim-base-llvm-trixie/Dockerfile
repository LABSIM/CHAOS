# syntax = docker/dockerfile:1.19.0


##################################
#                                #
#    LABSIM-BASE-LLVM-TRIXIE     #
#                                #
# ============================== #
# -> Debian:trixie               #
#  -> buildpack-deps:trixie-curl #
#   -> buildpack-deps:trixie-scm #
##################################


FROM docker.io/buildpack-deps:forky AS labsim-base-llvm-trixie
# FROM docker.io/gcc:15.2.0-trixie AS labsim-base-llvm-trixie

# prettifyng
LABEL description="LABSIM base distro - Linux Debian 13 & LLVM 21" \
      maintainer="nawfel.kinani@onera.fr" \
      version="1.0.0" \
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
ARG LLVM_VERSION=22

#
# update
#
RUN \
#     #
#     # repo installation specific tools
#     #
#     apt-get --quiet update \
#  && apt-get install --quiet --no-install-recommends --assume-yes \
#     wget \
#     gpg \
    #
    # LLVM repo installation
    # - see [https://apt.llvm.org/]
    # add it twice to workaround:
    # https://github.com/llvm/llvm-project/issues/62475
    #
#  && wget -qO- https://apt.llvm.org/llvm-snapshot.gpg.key | tee /etc/apt/trusted.gpg.d/apt.llvm.org.asc \ 
#  && add-apt-repository -y "deb http://apt.llvm.org/trixie/  llvm-toolchain-trixie-$LLVM_VERSION main" \
#  && add-apt-repository -y "deb-src http://apt.llvm.org/trixie/  llvm-toolchain-trixie-$LLVM_VERSION main" \
    #
    # refresh
    #
    apt-get --quiet update \
    #
    # install specific tools - yes to every prompt - no recommmended quiet
    #
 && apt-get install --no-install-recommends --assume-yes \
    #
    # generic package
    #
    wget \
    gpg \
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
    cmake \
    ninja-build \
    #
    # LLVM automatic script repo installation
    #
&& wget https://apt.llvm.org/llvm.sh \
&& chmod +x llvm.sh \
&& ./llvm.sh $LLVM_VERSION all \
   #  #
   #  # LLVM specific dependancies
   #  # - cmake required by default
   #  # - ninja build strongly recommended
   #  #
   #  cmake \
   #  ninja-build \
   #  #
   #  # LLVM full packages
   #  # - see [https://apt.llvm.org/]
   #  #
   #  # LLVM
   #  libllvm-$LLVM_VERSION-ocaml-dev \
   #  libllvm$LLVM_VERSION \
   #  llvm-$LLVM_VERSION \
   #  llvm-$LLVM_VERSION-dev \
   #  llvm-$LLVM_VERSION-runtime \
   #  # Clang and co
   #  clang-$LLVM_VERSION \
   #  clang-tools-$LLVM_VERSION \
   #  libclang-common-$LLVM_VERSION-dev \
   #  libclang-$LLVM_VERSION-dev \
   #  libclang1-$LLVM_VERSION \
   #  clang-format-$LLVM_VERSION \
   #  python3-clang-$LLVM_VERSION \
   #  clangd-$LLVM_VERSION \
   #  clang-tidy-$LLVM_VERSION \
   #  # compiler-rt
   #  libclang-rt-$LLVM_VERSION-dev \
   #  # polly
   #  libpolly-$LLVM_VERSION-dev \
   #  # libfuzzer
   #  libfuzzer-$LLVM_VERSION-dev \
   #  # lldb
   #  lldb-$LLVM_VERSION \
   #  # lld (linker)
   #  lld-$LLVM_VERSION \
   #  # libc++
   #  libc++-$LLVM_VERSION-dev \
   #  libc++abi-$LLVM_VERSION-dev \
   #  # OpenMP
   #  libomp-$LLVM_VERSION-dev \
   #  # libclc
   #  libclc-$LLVM_VERSION-dev \
   #  # libunwind
   #  libunwind-$LLVM_VERSION-dev \
   #  # mlir
   #  libmlir-$LLVM_VERSION-dev \
   #  mlir-$LLVM_VERSION-tools \
   #  # bolt
   #  libbolt-$LLVM_VERSION-dev \
   #  bolt-$LLVM_VERSION \
   #  # flang
   #  flang-$LLVM_VERSION \
   #  # wasm support
   #  libclang-rt-$LLVM_VERSION-dev-wasm32 \
   #  libclang-rt-$LLVM_VERSION-dev-wasm64 \
   #  libc++-$LLVM_VERSION-dev-wasm32 \
   #  libc++abi-$LLVM_VERSION-dev-wasm32 \
   #  libclang-rt-$LLVM_VERSION-dev-wasm32 \
   #  libclang-rt-$LLVM_VERSION-dev-wasm64 \
    #
    # "install" into standard env
    #
 #&& for f in /usr/lib/llvm-$LLVM_VERSION/bin/*; do ln -sf "$f" /usr/local/bin; done \
    #
    # LLVM python installation
    # - see [https://github.com/llvm/llvm-project/issues/55575]
    #
 #&& mkdir -p /usr/lib/lib/python3.9/site-packages \
 #&& ln -s /usr/lib/llvm-$LLVM_VERSION/lib/python3.9/site-packages/lldb /usr/lib/lib/python3.9/site-packages/lldb \
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