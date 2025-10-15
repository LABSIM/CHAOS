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
LABEL description="LABSIM base distro - Linux Debian 12 & GNU GCC 14" \
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
