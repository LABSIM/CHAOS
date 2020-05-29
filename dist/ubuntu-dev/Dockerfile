#
# Stage 0
#

# Ubuntu latest base config 
FROM ubuntu:rolling

# GitLab - LDAP
ARG GITLAB_USERNAME
ARG GITLAB_PASSWORD

# check mandatory
RUN if [ -z "$GITLAB_USERNAME" ]; then echo "[GAIA][Dockerfile] - ERROR : GITLAB_USERNAME arg not set, maybe you should set [--build-arg GITHUB_USERNAME={value}] options in CLI"; exit 1; else : ; fi
RUN if [ -z "$GITLAB_PASSWORD" ]; then echo "[GAIA][Dockerfile] - ERROR : GITLAB_PASSWORD arg not set, maybe you should set [--build-arg GITHUB_TOKEN={value}] options in CLI"; exit 1; else : ; fi

# update it - yes to every prompt + git
RUN apt-get update && apt-get --assume-yes install git

# setup titans dir
WORKDIR /labsim/titans

# clone LABSIM sources from server
RUN \
    git clone https://${GITLAB_USERNAME}:${GITLAB_PASSWORD}@gitlab-dtis.onera/LABSIM/GAIA.git \
    git clone https://${GITLAB_USERNAME}:${GITLAB_PASSWORD}@gitlab-dtis.onera/LABSIM/OURANOS.git \
    git clone https://${GITLAB_USERNAME}:${GITLAB_PASSWORD}@gitlab-dtis.onera/LABSIM/THETYS.git \
    git clone https://${GITLAB_USERNAME}:${GITLAB_PASSWORD}@gitlab-dtis.onera/LABSIM/OCEAN.git \
    git clone https://${GITLAB_USERNAME}:${GITLAB_PASSWORD}@gitlab-dtis.onera/LABSIM/RHEA.git \
    git clone https://${GITLAB_USERNAME}:${GITLAB_PASSWORD}@gitlab-dtis.onera/LABSIM/KRONOS.git

# setup third_party dir
WORKDIR /labsim/third_party

# install vcpkg
RUN \
    git clone https://github.com/Microsoft/vcpkg.git \
    && cd vcpkg \
    && ./bootstrap-vcpkg.sh \
    && ./vcpkg integrate install