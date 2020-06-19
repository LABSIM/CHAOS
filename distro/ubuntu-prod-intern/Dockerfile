# syntax = docker/dockerfile:1.0-experimental

# Ubuntu latest base config 
FROM ubuntu:20.04 as labsim-setup-stage

# prettifyng
LABEL description="LABSIM build-stage container for intern dev"

# mandatory argument
ARG GAIA_TARGET_ECOSYSTEM
ARG GAIA_ENABLE_FEATURE

# tzdata : Timezone + noninteractive
ARG TZ=Europe/Paris
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
 && cpanm --verbose \
        List::Util \
        local::lib \
        FindBin \
        Switch \
        Env \
        Config \
        Getopt::Long \
        Pod::Usage \
        Term::ANSIColor \
        Time::HiRes \
        Data::Dumper \
        File::Copy::Recursive \
        File::Remove \
        File::Spec \
        File::HomeDir \
        YAML::XS \
        Net::Address::IP::Local \
        IPC::System::Simple \
        IPC::Cmd \
        XML::SimpleObject::LibXML \
        Graph

# setup local for environment
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8

# setup titans dir, clone LABSIM sources from internal gitlab, then integrate gaia mandatory GNU feature 
WORKDIR /labsim/dev/titans
RUN --mount=type=secret,id=GITLAB_USERNAME,required \
    --mount=type=secret,id=GITLAB_TOKEN,required \
    git clone https://$(cat /run/secrets/GITLAB_USERNAME):$(cat /run/secrets/GITLAB_TOKEN)@gitlab-dtis.onera/LABSIM/GAIA.git \
 && git clone https://$(cat /run/secrets/GITLAB_USERNAME):$(cat /run/secrets/GITLAB_TOKEN)@gitlab-dtis.onera/LABSIM/OURANOS.git \
 && git clone https://$(cat /run/secrets/GITLAB_USERNAME):$(cat /run/secrets/GITLAB_TOKEN)@gitlab-dtis.onera/LABSIM/THETYS.git \
 && git clone https://$(cat /run/secrets/GITLAB_USERNAME):$(cat /run/secrets/GITLAB_TOKEN)@gitlab-dtis.onera/LABSIM/OCEAN.git \
 && git clone https://$(cat /run/secrets/GITLAB_USERNAME):$(cat /run/secrets/GITLAB_TOKEN)@gitlab-dtis.onera/LABSIM/RHEA.git \
 && git clone https://$(cat /run/secrets/GITLAB_USERNAME):$(cat /run/secrets/GITLAB_TOKEN)@gitlab-dtis.onera/LABSIM/KRONOS.git \
 && cd GAIA \
    : "${GAIA_TARGET_ECOSYSTEM:?GAIA target-ecosystem argument needs to be set and non-empty.}" \
    : "${GAIA_ENABLE_FEATURE:?GAIA enable-feature argument needs to be set and non-empty.}" \
 && chmod +x bootstrap-gaia.sh \
#  && ./bootstrap-gaia.sh --verbosity-level debug --target-ecosystem ${GAIA_TARGET_ECOSYSTEM} --enable-feature gnu
 && ./bootstrap-gaia.sh --verbosity-level debug --target-ecosystem ${GAIA_TARGET_ECOSYSTEM} --enable-feature ${GAIA_ENABLE_FEATURE}

# cleanup temporary
RUN rm -rf /tmp