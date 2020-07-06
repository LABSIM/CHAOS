# syntax = docker/dockerfile:1.0-experimental

# -> Debian:buster 
#  -> buildpack-deps:buster-curl 
#   -> buildpack-deps:buster-scm 
#    -> buildpack-deps:buster 
#     -> gcc:10.1.0
FROM gcc:10.1.0 as labsim-dev

# prettifyng
LABEL description="LABSIM external development distro - Linux & GNU GCC based"

# mandatory argument + noninteractive
ARG GAIA_TARGET_ECOSYSTEM
ARG GAIA_ENABLE_FEATURE
ARG DEBIAN_FRONTEND=noninteractive

# update/install recquired packages - yes to every prompt - then, cleanup & set locale
RUN apt-get update \
 && apt-get --no-install-recommends --assume-yes install \
        gawk \
        bison \
        flex \
        locales \
        libzstd-dev \
        zstd \
        gdb \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/* \
 && locale-gen en_US.UTF-8 \
 && localedef -i en_US -f UTF-8 en_US.UTF-8

# timezone & locales
ENV TZ "Europe/Paris"
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8

# setup LABSIM titans : create dirs, clone sources from github, then integrate gaia features
WORKDIR /labsim/dev/titans
RUN --mount=type=secret,id=GITHUB_USERNAME,required \
    --mount=type=secret,id=GITHUB_TOKEN,required \
    git clone https://$(cat /run/secrets/GITHUB_USERNAME):$(cat /run/secrets/GITHUB_TOKEN)@github.com/LABSIM/GAIA.git \
 && git clone https://$(cat /run/secrets/GITHUB_USERNAME):$(cat /run/secrets/GITHUB_TOKEN)@github.com/LABSIM/OURANOS.git \
 && git clone https://$(cat /run/secrets/GITHUB_USERNAME):$(cat /run/secrets/GITHUB_TOKEN)@github.com/LABSIM/THETYS.git \
 && git clone https://$(cat /run/secrets/GITHUB_USERNAME):$(cat /run/secrets/GITHUB_TOKEN)@github.com/LABSIM/OCEAN.git \
 && git clone https://$(cat /run/secrets/GITHUB_USERNAME):$(cat /run/secrets/GITHUB_TOKEN)@github.com/LABSIM/RHEA.git \
 && git clone https://$(cat /run/secrets/GITHUB_USERNAME):$(cat /run/secrets/GITHUB_TOKEN)@github.com/LABSIM/KRONOS.git \
 && cd GAIA \
    : "${GAIA_TARGET_ECOSYSTEM:?GAIA target-ecosystem argument needs to be set and non-empty.}" \
    : "${GAIA_ENABLE_FEATURE:?GAIA enable-feature argument needs to be set and non-empty.}" \
 && chmod +x bootstrap-gaia.sh \
 && ./bootstrap-gaia.sh --verbosity-level debug --target-ecosystem ${GAIA_TARGET_ECOSYSTEM} --enable-feature ${GAIA_ENABLE_FEATURE}

# setup LABSIM workspace
WORKDIR /labsim/dev
COPY distro/linux-gcc-dev-extern/labsim.code-workspace .
# for the moment, this extension fail to install by itself, so we provide a temporary archive
RUN wget https://github.com/microsoft/vscode-cpptools/releases/download/0.29.0-insiders/cpptools-linux.vsix

# cleanup temporary
RUN rm -rf /tmp