# syntax = docker/dockerfile:1.19.0


##################################
#                                #
# LABSIM-DEVCONTAINER-GCC-TRIXIE #
#                                #
# ============================== #
# -> labsim-base-gcc-trixie      #
##################################


FROM labsim-base-gcc-trixie:latest AS labsim-devcontainer-gcc-trixie

# prettifyng
LABEL description="LABSIM devcontainer distro - Linux Debian 13 & GNU GCC 15" \
      maintainer="nawfel.kinani@onera.fr" \
      version="1.0.0" \
      org.name="ONERA" \
      org.department="DTIS" \
      org.unit="ICNA" \
      org.laboratory="LABSIM" \
      org.center="Salon-de-Provence" \
      license="GNU GPLv3"

#
# avoid warnings by switching to noninteractive during build 
# --> ARG because it is not persisted in the final image vs. ENV
#
ARG DEBIAN_FRONTEND=noninteractive

#
# mandatory argument : GAIA + user
#
ARG GAIA_TARGET_ECOSYSTEM="3.0.0"
ARG USERNAME=labsim
ARG USER_UID=1000
ARG USER_GID=$USER_UID

RUN \
    #
    # print
    #
    set -ex \
    #
    # create the labsim dev user
    #
 && groupadd --gid $USER_GID $USERNAME \
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
 && apt-get dist-clean --quiet \
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
 && sudo git clone --recurse-submodules https://$(cat /run/secrets/GITHUB_USERNAME):$(cat /run/secrets/GITHUB_TOKEN)@github.com/LABSIM/ZEUS.git olympiens/ZEUS \
    #
    # give all access to labsim
    #
&& sudo chown -R $USERNAME /home/$USERNAME \
&& sudo chgrp -R $USERNAME /home/$USERNAME \
    #
    # GAIA ecosystem - bootstrap, install & export LABSIM SSE SDK through VCPKG. Then finally, remove temporary installation dir & configure .bashrc
    #
 && cd titans/GAIA/ecosystem/${GAIA_TARGET_ECOSYSTEM}/ \
 && ../../third_party/vcpkg/bootstrap-vcpkg.sh \
 && ../../third_party/vcpkg/vcpkg install --clean-after-build \
 && ../../third_party/vcpkg/vcpkg export --raw --output-dir=/home/$USERNAME --output=third_party \
 && rm -rf vcpkg_installed \
 && echo /home/$USERNAME/dev/titans/GAIA/ecosystem/$GAIA_TARGET_ECOSYSTEM/GAIA.bashrc >> /home/$USERNAME/.bashrc

#
# finally, inject the LABSIM SSE VSCode workspace
#
COPY --chown=$USERNAME:$USERNAME distro/labsim/labsim.code-workspace /home/$USERNAME/dev
