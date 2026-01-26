# syntax = docker/dockerfile:1.19.0


##################################
#                                #
#    LABSIM-BASE-GCC-TRIXIE      #
#                                #
# ============================== #
# -> Debian:trixie               #
#  -> buildpack-deps:trixie-curl #
#   -> buildpack-deps:trixie-scm #
#    -> buildpack-deps:trixie    #
#     -> gcc:15.2.0-trixie       #
##################################


FROM docker.io/gcc:15.2.0-trixie AS labsim-base-gcc-trixie

# prettifyng
LABEL description="LABSIM base distro - Linux Debian 13 & GNU GCC 15" \
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
# command
#
RUN set -ex; \
	 #
    # refresh
 && apt-get --quiet update \
    #
    # install specific tools - yes to every prompt - no recommmended
    #
 && apt-get install --quiet --no-install-recommends --assume-yes \
    #
    # packages
    #
    zip \
    tar \
    gpg \
    apt-transport-https \
    locales \
    ccache \
    cmake \
    ninja-build \
    vim \
    man \
    gdb \
    valgrind \
    perl \
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
