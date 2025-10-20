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


FROM docker.io/buildpack-deps:trixie AS labsim-base-llvm-trixie

# prettifyng
LABEL description="LABSIM base distro - Linux Debian 13 & LLVM 20" \
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
ARG LLVM_VERSION=20

#
# update
#
RUN \
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
    libxerces-c-dev \
    #
    # LLVM automatic script repo installation
    #
&& wget https://apt.llvm.org/llvm.sh \
&& chmod +x llvm.sh \
&& ./llvm.sh $LLVM_VERSION all \
    #
    # "install" into standard env
    #
 && for f in /usr/lib/llvm-$LLVM_VERSION/bin/*; do ln -sf "$f" /usr/local/bin; done \
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