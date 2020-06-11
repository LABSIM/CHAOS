#
# Stage 0
#

# CentOS latest base config 
FROM centos:latest

# Github 2FA CLI
ARG GITHUB_USERNAME
ARG GITHUB_TOKEN

# mandatory
RUN if [ -z "$GITHUB_USERNAME" ]; then echo "[GAIA][Dockerfile] - ERROR : GITHUB_USERNAME arg not set, maybe you should set [--build-arg GITHUB_USERNAME={value}] options in CLI"; exit 1; else : ; fi
RUN if [ -z "$GITHUB_TOKEN" ]; then echo "[GAIA][Dockerfile] - ERROR : GITHUB_TOKEN arg not set, maybe you should set [--build-arg GITHUB_TOKEN={value}] options in CLI"; exit 1; else : ; fi

# update it - yes to every prompt + git
RUN yum -y update && yum -y install git && yum clean all

# setup titans dir
WORKDIR /labsim/titans

# clone LABSIM sources from server
RUN git clone https://${GITHUB_USERNAME}:${GITHUB_TOKEN}@github.com/LABSIM/GAIA.git
RUN git clone https://${GITHUB_USERNAME}:${GITHUB_TOKEN}@github.com/LABSIM/OURANOS.git
RUN git clone https://${GITHUB_USERNAME}:${GITHUB_TOKEN}@github.com/LABSIM/THETYS.git
RUN git clone https://${GITHUB_USERNAME}:${GITHUB_TOKEN}@github.com/LABSIM/OCEAN.git
RUN git clone https://${GITHUB_USERNAME}:${GITHUB_TOKEN}@github.com/LABSIM/RHEA.git
RUN git clone https://${GITHUB_USERNAME}:${GITHUB_TOKEN}@github.com/LABSIM/KRONOS.git
