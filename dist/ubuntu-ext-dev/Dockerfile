# syntax = docker/dockerfile:1.0-experimental

#
# Stage 0
#

# Ubuntu latest base config 
FROM ubuntu:rolling

# update/install recquired packages - yes to every prompt - then, set locale
RUN apt-get update && apt-get --assume-yes install \
        build-essential git curl wget unzip tar perl locales \
    && locale-gen en_US.UTF-8  

# setup local for environment
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

# setup titans dir & clone LABSIM sources from server
WORKDIR /labsim/dev/titans
RUN --mount=type=secret,id=GITHUB_USERNAME,required \
    --mount=type=secret,id=GITHUB_TOKEN,required \
    git clone https://$(cat /run/secrets/GITHUB_USERNAME):$(cat /run/secrets/GITHUB_TOKEN)@github.com/LABSIM/GAIA.git \
    && git clone https://$(cat /run/secrets/GITHUB_USERNAME):$(cat /run/secrets/GITHUB_TOKEN)@github.com/LABSIM/OURANOS.git \
    && git clone https://$(cat /run/secrets/GITHUB_USERNAME):$(cat /run/secrets/GITHUB_TOKEN)@github.com/LABSIM/THETYS.git \
    && git clone https://$(cat /run/secrets/GITHUB_USERNAME):$(cat /run/secrets/GITHUB_TOKEN)@github.com/LABSIM/OCEAN.git \
    && git clone https://$(cat /run/secrets/GITHUB_USERNAME):$(cat /run/secrets/GITHUB_TOKEN)@github.com/LABSIM/RHEA.git \
    && git clone https://$(cat /run/secrets/GITHUB_USERNAME):$(cat /run/secrets/GITHUB_TOKEN)@github.com/LABSIM/KRONOS.git

# setup third_party dev
WORKDIR /labsim/dev/third_party
RUN git clone https://github.com/Microsoft/vcpkg.git

# setup third_party install dir
WORKDIR /labsim/third_party

# configure gaia
WORKDIR /labsim/dev/titans/GAIA
RUN chmod +x bootstrap-gaia.sh \
    && ./bootstrap-gaia.sh
#    && gaia --target-ecosystem LABSIM-2.0.0 --enable-feature gnu

# configure vcpkg
#WORKDIR /labsim/third_party/vcpkg
#RUN chmod +x booststrap-vcpkg.sh \ 
#    && ./bootstrap-vcpkg.sh -disableMetrics \
#    && vcpkg integrate install

