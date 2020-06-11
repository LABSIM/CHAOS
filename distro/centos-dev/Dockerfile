#
# Stage 0
#

# CentOS latest base config 
FROM centos:latest

# GitLab - LDAP
ARG GITLAB_USERNAME
ARG GITLAB_PASSWORD

# check mandatory
RUN if [ -z "$GITLAB_USERNAME" ]; then echo "[GAIA][Dockerfile] - ERROR : GITLAB_USERNAME arg not set, maybe you should set [--build-arg GITHUB_USERNAME={value}] options in CLI"; exit 1; else : ; fi
RUN if [ -z "$GITLAB_PASSWORD" ]; then echo "[GAIA][Dockerfile] - ERROR : GITLAB_PASSWORD arg not set, maybe you should set [--build-arg GITHUB_TOKEN={value}] options in CLI"; exit 1; else : ; fi

# update it - yes to every prompt + git
RUN yum -y update && yum -y install git && yum clean all

# setup titans dir
WORKDIR /labsim/titans

# clone LABSIM sources from server
RUN git clone https://${GITLAB_USERNAME}:${GITLAB_PASSWORD}@gitlab-dtis.onera/LABSIM/GAIA.git
RUN git clone https://${GITLAB_USERNAME}:${GITLAB_PASSWORD}@gitlab-dtis.onera/LABSIM/OURANOS.git
RUN git clone https://${GITLAB_USERNAME}:${GITLAB_PASSWORD}@gitlab-dtis.onera/LABSIM/THETYS.git
RUN git clone https://${GITLAB_USERNAME}:${GITLAB_PASSWORD}@gitlab-dtis.onera/LABSIM/OCEAN.git
RUN git clone https://${GITLAB_USERNAME}:${GITLAB_PASSWORD}@gitlab-dtis.onera/LABSIM/RHEA.git
RUN git clone https://${GITLAB_USERNAME}:${GITLAB_PASSWORD}@gitlab-dtis.onera/LABSIM/KRONOS.git
