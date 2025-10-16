# syntax = docker/dockerfile:1.4.3


####################################
#                                  #
# LABSIM-DEVCONTAINER-GCC-BOOKWORM #
#                                  #
# ================================ #
# -> labsim-base-gcc-bookworm      #
####################################


FROM labsim-base-gcc-bookworm:latest AS labsim-devcontainer-gcc-bookworm

# prettifyng
LABEL description="LABSIM devcontainer distro - Linux Debian 12 & GNU GCC 14" \
      maintainer="nawfel.kinani@onera.fr" \
      version="1.0.0" \
      org.name="ONERA" \
      org.department="DTIS" \
      org.unit="ICNA" \
      org.laboratory="LABSIM" \
      org.center="Salon-de-Provence" \
      license="GNU GPLv3"

#
# mandatory argument : GAIA + user
#
ARG GAIA_TARGET_ECOSYSTEM="2.0.1"
ARG GAIA_ENABLE_FEATURE="dev,sb,sf"
ARG USERNAME=labsim
ARG USER_UID=1000
ARG USER_GID=$USER_UID

RUN \
    #
    # create the labsim dev user
    #
    groupadd --gid $USER_GID $USERNAME \
 && useradd --uid $USER_UID --gid $USER_GID --create-home --shell /bin/bash --no-log-init $USERNAME \
    #
    # add sudo support (Omit if you don't need to install software after connecting.)
    #
 && apt-get update \
 && apt-get install -y sudo \
 && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
 && chmod 0440 /etc/sudoers.d/$USERNAME \
    #
    # apt cleanup
    #
 && apt-get autoremove --quiet --purge -y \
 && apt-get clean --quiet \
 && rm -rf /var/lib/apt/lists/* 

#
# setup the LABSIM Simulation Software Ecosystem (SSE) : 
# -> default user
# -> default dev dir
# -> clone repos
# -> integrate GAIA features 
# -> setup VSCode workspace
#
USER $USERNAME
WORKDIR /home/$USERNAME/dev
RUN \
    #
    # mount build secrets
    #
    --mount=type=secret,mode=0444,id=GITHUB_USERNAME,required=true \
    --mount=type=secret,mode=0444,id=GITHUB_TOKEN,required=true \
    #
    # clone LABSIM repositories
    #
    sudo git clone --recurse-submodules https://$(cat /run/secrets/GITHUB_USERNAME):$(cat /run/secrets/GITHUB_TOKEN)@github.com/LABSIM/GAIA.git titans/GAIA \
 && sudo git clone --recurse-submodules https://$(cat /run/secrets/GITHUB_USERNAME):$(cat /run/secrets/GITHUB_TOKEN)@github.com/LABSIM/OURANOS.git titans/OURANOS \
 && sudo git clone --recurse-submodules https://$(cat /run/secrets/GITHUB_USERNAME):$(cat /run/secrets/GITHUB_TOKEN)@github.com/LABSIM/THETYS.git titans/THETYS \
 && sudo git clone --recurse-submodules https://$(cat /run/secrets/GITHUB_USERNAME):$(cat /run/secrets/GITHUB_TOKEN)@github.com/LABSIM/OCEAN.git titans/OCEAN \
 && sudo git clone --recurse-submodules https://$(cat /run/secrets/GITHUB_USERNAME):$(cat /run/secrets/GITHUB_TOKEN)@github.com/LABSIM/RHEA.git titans/RHEA \
 && sudo git clone --recurse-submodules https://$(cat /run/secrets/GITHUB_USERNAME):$(cat /run/secrets/GITHUB_TOKEN)@github.com/LABSIM/KRONOS.git titans/KRONOS \
    #
    # give all access to labsim
    #
&& sudo chown -R $USERNAME /home/$USERNAME \
&& sudo chgrp -R $USERNAME /home/$USERNAME \
    #
    # bootstrap & run GAIA
    #
 && cd titans/GAIA \
 && /usr/bin/env bash GAIA-bootstrap --verbosity-level info --target-ecosystem ${GAIA_TARGET_ECOSYSTEM} --enable-feature ${GAIA_ENABLE_FEATURE}

#
# finally, inject the LABSIM SSE VSCode workspace
#
COPY --chown=$USERNAME:$USERNAME distro/labsim/labsim.code-workspace /home/$USERNAME/dev
