#
# Stage 0
#

# Ubuntu latest base config 
FROM ubuntu:rolling

# Github 2FA CLI
ARG GITHUB_USERNAME
ARG GITHUB_TOKEN

# mandatory check, update/install recquired packages - yes to every prompt - then, set locale
RUN [ -z "$GITHUB_USERNAME" ] && echo "[GAIA][Dockerfile] - ERROR : GITHUB_USERNAME arg not set, maybe you should set [--build-arg GITHUB_USERNAME={value}] options in CLI"; exit 1; \
    && [ -z "$GITHUB_TOKEN" ] && echo "[GAIA][Dockerfile] - ERROR : GITHUB_TOKEN arg not set, maybe you should set [--build-arg GITHUB_TOKEN={value}] options in CLI"; exit 1; \
    && apt-get update && apt-get --assume-yes install \
        build-essential git curl wget unzip tar perl locales \
    && locale-gen en_US.UTF-8  

# setup local for environment
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

# setup titans dir & clone LABSIM sources from server
WORKDIR /labsim/dev/titans
RUN git clone https://${GITHUB_USERNAME}:${GITHUB_TOKEN}@github.com/LABSIM/GAIA.git \
    && git clone https://${GITHUB_USERNAME}:${GITHUB_TOKEN}@github.com/LABSIM/OURANOS.git \
    && git clone https://${GITHUB_USERNAME}:${GITHUB_TOKEN}@github.com/LABSIM/THETYS.git \
    && git clone https://${GITHUB_USERNAME}:${GITHUB_TOKEN}@github.com/LABSIM/OCEAN.git \
    && git clone https://${GITHUB_USERNAME}:${GITHUB_TOKEN}@github.com/LABSIM/RHEA.git \
    && git clone https://${GITHUB_USERNAME}:${GITHUB_TOKEN}@github.com/LABSIM/KRONOS.git

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

