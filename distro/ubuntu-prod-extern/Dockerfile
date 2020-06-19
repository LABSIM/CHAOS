# syntax = docker/dockerfile:1.0-experimental

# Ubuntu latest base config 
FROM ubuntu:rolling as labsim-setup-stage

# prettifyng
LABEL description="LABSIM build-stage container for intern dev"

# mandatory argument & noninteractive
ARG GAIA_TARGET_ECOSYSTEM
ARG GAIA_ENABLE_FEATURE
ARG DEBIAN_FRONTEND=noninteractive

# update/install recquired packages - yes to every prompt - then, set locale & install specific perl module
RUN apt-get update \
 && apt-get --no-install-recommends --assume-yes install \
        automake \
        autoconf \
        autogen \
        make \
        libtool \
        pkg-config \
        m4 \
        build-essential \
        linux-headers-generic \
        texinfo \
        curl \
        wget \
        git \
        ca-certificates \
        unzip \
        tar \
        locales \
        tzdata \
        perl \
        cpanminus \
        libffi-dev \
        libzstd-dev \
        zstd \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/* \
 && locale-gen en_US.UTF-8 \
 && localedef -i en_US -f UTF-8 en_US.UTF-8

# setup timezone & locales for environment
ENV TZ "Europe/Paris"
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8

# setup titans dir, clone LABSIM sources from github, then integrate gaia mandatory GNU feature 
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
#  && ./bootstrap-gaia.sh --verbosity-level debug --target-ecosystem ${GAIA_TARGET_ECOSYSTEM} --enable-feature gnu
 && ./bootstrap-gaia.sh --verbosity-level debug --target-ecosystem ${GAIA_TARGET_ECOSYSTEM} --enable-feature ${GAIA_ENABLE_FEATURE}

# cleanup temporary
RUN rm -rf /tmp