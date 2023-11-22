# syntax = docker/dockerfile:1.4.3


####################################
#                                  #
# SCHEME-GATEWAY-BASE-GCC-BOOKWORM #
#                                  #
# ================================ #
# -> Debian:bookworm               #
#  -> buildpack-deps:bookworm-curl #
#   -> buildpack-deps:bookworm-scm #
#    -> buildpack-deps:bookworm    #
#     -> gcc:13.2.0-bookworm       #
####################################


FROM gcc:13.2.0-bookworm as scheme-gateway-base-gcc-bookworm

# prettifyng
LABEL description="SCHEME-GATEWAY base distro - Linux Debian 12 & GNU GCC 13.2.0" \
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
RUN useradd --create-home --user-group --shell /bin/bash --no-log-init scheme 


############################################
#                                          #
# SCHEME-GATEWAY-DEVCONTAINER-GCC-BOOKWORM #
#                                          #
# ======================================== #
# -> scheme-gateway-base-gcc-bookworm      #
############################################


# multi stage build
FROM scheme-gateway-base-gcc-bookworm as scheme-gateway-devcontainer-gcc-bookworm

# prettifyng
LABEL description="SCHEME-GATEWAY devcontainer distro - Linux Debian 12 & GNU GCC 13.2.0" \
      maintainer="nawfel.kinani@onera.fr" \
      version="0.0.1" \
      org.name="ONERA" \
      org.department="DTIS" \
      org.unit="ICNA" \
      org.laboratory="LABSIM" \
      org.center="Salon-de-Provence" \
      license="GNU GPLv3"

# set user ID
USER scheme

# setup LABSIM Simulation Software Ecosysten : create dir, clone sources from github, then integrate gaia features & VSCode workspace
WORKDIR /home/scheme/dev

# mandatory GAIA argument
ARG GAIA_TARGET_ECOSYSTEM="2.0.0" \
    GAIA_ENABLE_FEATURE="dev,sf"

#
# mount build secrets
#
RUN --mount=type=secret,mode=0444,id=GITHUB_USERNAME,required=true \
    --mount=type=secret,mode=0444,id=GITHUB_TOKEN,required=true \
    #
    # clone LABSIM repositories
    #
    git clone --recurse-submodules https://$(cat /run/secrets/GITHUB_USERNAME):$(cat /run/secrets/GITHUB_TOKEN)@github.com/LABSIM/GAIA.git titans/GAIA \
    #
    # finally, bootstrap GAIA
    #
 && cd titans/GAIA \
 && chmod +x GAIA-bootstrap \
 && ./GAIA-bootstrap --verbosity-level info --target-ecosystem ${GAIA_TARGET_ECOSYSTEM} --enable-feature ${GAIA_ENABLE_FEATURE}
 
# inject the LABSIM SSE VSCode workspace
COPY --chown=scheme:scheme distro/scheme-gateway/docker/scheme-gateway.code-workspace .