#
# Stage 0
#

# Ubuntu latest base config 
FROM ubuntu:rolling

# Github 2FA CLI
ARG GITHUB_USERNAME
ARG GITHUB_TOKEN

# mandatory
RUN if [ -z "$GITHUB_USERNAME" ]; then echo "[GAIA][Dockerfile] - ERROR : GITHUB_USERNAME arg not set, maybe you should set [--build-arg GITHUB_USERNAME={value}] options in CLI"; exit 1; else : ; fi
RUN if [ -z "$GITHUB_TOKEN" ]; then echo "[GAIA][Dockerfile] - ERROR : GITHUB_TOKEN arg not set, maybe you should set [--build-arg GITHUB_TOKEN={value}] options in CLI"; exit 1; else : ; fi

# update it - yes to every prompt - + recquired packages
RUN apt-get update && apt-get --assume-yes install git curl unzip tar perl

# setup titans dir & clone LABSIM sources from server

WORKDIR /labsim/dev/titans
RUN git clone https://${GITHUB_USERNAME}:${GITHUB_TOKEN}@github.com/LABSIM/GAIA.git \
    && cd GAIA \
    && ./bootstrap-gaia.sh \
    && ./gaia --target-ecosystem LABSIM-2.0.0 --enable-feature gnu

# setup third_party dir & install vcpkg
WORKDIR /labsim/third_party
RUN git clone https://github.com/Microsoft/vcpkg.git \
    && cd vcpkg \
    && ./bootstrap-vcpkg.sh -disableMetrics \
    && ./vcpkg integrate install
 
# setup titans dir & clone LABSIM sources from server
WORKDIR /labsim/dev/titans
RUN git clone https://${GITHUB_USERNAME}:${GITHUB_TOKEN}@github.com/LABSIM/OURANOS.git \
    && git clone https://${GITHUB_USERNAME}:${GITHUB_TOKEN}@github.com/LABSIM/THETYS.git \
    && git clone https://${GITHUB_USERNAME}:${GITHUB_TOKEN}@github.com/LABSIM/OCEAN.git \
    && git clone https://${GITHUB_USERNAME}:${GITHUB_TOKEN}@github.com/LABSIM/RHEA.git \
    && git clone https://${GITHUB_USERNAME}:${GITHUB_TOKEN}@github.com/LABSIM/KRONOS.git
