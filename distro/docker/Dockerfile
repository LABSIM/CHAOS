# syntax = docker/dockerfile:1.4.3


################################
#                              #
#         LABSIM-BASE          #
#                              #
################################


# -> Debian:bullseye 
#  -> buildpack-deps:bullseye-curl 
#   -> buildpack-deps:bullseye-scm 
#    -> buildpack-deps:bullseye 
#     -> gcc:12.2.0-bullseye
FROM gcc:12.2.0-bullseye as labsim-base

# prettifyng
LABEL description="LABSIM base distro - Linux & GNU GCC" \
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
RUN apt-get update \
    #
    # install specific tools - yes to every prompt - no recommmended
    #
 && apt-get --no-install-recommends --assume-yes install \
    apt-transport-https \
    bison \
    ca-certificates \
    ccache \
    clang-format \
    clang-tidy \
    flex \
    gawk \
    gnupg2 \
    gdb \
    git \
    locales \
    libzstd-dev \
    libncurses-dev \
    libacl1-dev \
    wget \
    zstd \
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
    LANG=en_US.UTF-8

# add & set labsim user
RUN useradd --create-home --user-group --shell /bin/bash --no-log-init labsim 
USER labsim


################################
#                              #
#     LABSIM-DEVCONTAINER      #
#                              #
################################


# multi stage build
FROM labsim-base as labsim-devcontainer

# prettifyng
LABEL description="LABSIM devcontainer distro - Linux & GNU GCC" \
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

