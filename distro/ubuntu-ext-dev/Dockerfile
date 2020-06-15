# syntax = docker/dockerfile:1.0-experimental

# Ubuntu latest base config 
FROM ubuntu:rolling as labsim-build-stage

# prettifyng
LABEL description="LABSIM build-stage container for remote dev"

# mandatory argument
ARG GAIA_TARGET_ECOSYSTEM
ARG GAIA_ENABLE_FEATURE

# update/upgrade/install recquired packages - yes to every prompt - then, set locale
RUN apt-get update && apt-get --assume-yes upgrade && apt-get --assume-yes install \
        build-essential linux-headers-generic m4 git curl wget unzip tar locales \ 
    && locale-gen en_US.UTF-8

# setup local for environment
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

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
    && ./bootstrap-gaia.sh --verbosity-level debug --target-ecosystem ${GAIA_TARGET_ECOSYSTEM} --enable-feature gnu

# setup third_party dev
WORKDIR /labsim/dev/third_party/vcpkg
RUN git clone https://github.com/Microsoft/vcpkg.git . \
    && chmod +x bootstrap-vcpkg.sh \
    && ./bootstrap-vcpkg.sh -disableMetrics \
    && ./vcpkg integrate install

# then integrate gaia ecosystem with required features
#WORKDIR /labsim/dev/titans/GAIA
#UN chmod +x GAIA.pl \
#    && /bin/bash -c 'source /labsim/dev/titans/GAIA/script/sh/GAIA.bashrc && ${0} ${1+"$@"}' ./GAIA.pl --verbosity-level debug --target-ecosystem ${GAIA_TARGET_ECOSYSTEM} --enable-feature ${GAIA_ENABLE_FEATURE}

# cleanup temporary
RUN rm -rf /tmp