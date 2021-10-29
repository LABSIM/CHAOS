# syntax = docker/dockerfile:1.3-labs


################################
#                              #
#         LABSIM-BASE          #
#                              #
################################


# -> Debian:bullseye 
#  -> buildpack-deps:bullseye-curl 
#   -> buildpack-deps:bullseye-scm 
#    -> buildpack-deps:bullseye 
#     -> gcc:11.2.0-bullseye
FROM gcc:11.2.0-bullseye as labsim-base

# prettifyng
LABEL description="LABSIM external development distro - Linux & GNU GCC based" \
      maintainer="nawfel.kinani@onera.fr" \
      version="1.0" \
      org.name="ONERA" \
      org.department="DTIS" \
      org.unit="ICNA" \
      org.laboratory="LABSIM" \
      org.center="Salon-de-Provence" \
      license="GNU GPLv3"

# avoid warnings by switching to noninteractive during build 
# --> ARG because it is not persisted in the final image vs. ENV
ARG DEBIAN_FRONTEND=noninteractive

#
# update
#
RUN apt-get update \
    #
    # install specific tools - yes to every prompt - no recommmended
    #
 && apt-get --no-install-recommends --assume-yes install \
      gawk \
      bison \
      flex \
      locales \
      libzstd-dev \
      zstd \
      gdb \
      ccache \
    #
    # cleanup
    #
 && apt-get autoremove --purge -y \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/* \
    #
    # then, setup locale
    #
 && locale-gen en_US.UTF-8 \
 && localedef -i en_US -f UTF-8 en_US.UTF-8

# switch back to dialog for any ad-hoc use of apt-get
# ARG DEBIAN_FRONTEND=dialog

# timezone & env locales
ENV TZ=Europe/Paris \
    LANGUAGE=en_US:en \
    LC_ALL=en_US.UTF-8 \
    LANG=en_US.UTF-8

# add & set labsim user
RUN useradd --no-log-init --user-group --create-home --shell /bin/bash labsim
USER labsim


################################
#                              #
#     LABSIM-DEVCONTAINER      #
#                              #
################################


# multi stage build
FROM labsim-base as labsim-devcontainer

# setup LABSIM Simulation Software Ecosysten : create dir, clone sources from github, then integrate gaia features & VSCode workspace
WORKDIR /home/labsim/dev

# mandatory GAIA argument
ARG GAIA_TARGET_ECOSYSTEM="LABSIM-2.0.0" \
    GAIA_ENABLE_FEATURE="dev,sf"
#    GAIA_ENABLE_FEATURE="dev,sf,sb"

#
# mount secrets, clone LABSIM repositories & bootstrap GAIA
#
RUN --mount=type=secret,mode=0444,id=GITHUB_USERNAME,required=true \
    --mount=type=secret,mode=0444,id=GITHUB_TOKEN,required=true \
    git clone https://$(cat /run/secrets/GITHUB_USERNAME):$(cat /run/secrets/GITHUB_TOKEN)@github.com/LABSIM/GAIA.git titans/GAIA \
 && git clone https://$(cat /run/secrets/GITHUB_USERNAME):$(cat /run/secrets/GITHUB_TOKEN)@github.com/LABSIM/OURANOS.git titans/OURANOS \
 && git clone --recurse-submodules https://$(cat /run/secrets/GITHUB_USERNAME):$(cat /run/secrets/GITHUB_TOKEN)@github.com/LABSIM/THETYS.git titans/THETYS \
 && git clone https://$(cat /run/secrets/GITHUB_USERNAME):$(cat /run/secrets/GITHUB_TOKEN)@github.com/LABSIM/OCEAN.git titans/OCEAN \
 && git clone https://$(cat /run/secrets/GITHUB_USERNAME):$(cat /run/secrets/GITHUB_TOKEN)@github.com/LABSIM/RHEA.git titans/RHEA \
 && git clone https://$(cat /run/secrets/GITHUB_USERNAME):$(cat /run/secrets/GITHUB_TOKEN)@github.com/LABSIM/KRONOS.git titans/KRONOS \
 && cd titans/GAIA \
 && chmod +x bootstrap-gaia.sh \
 && ./bootstrap-gaia.sh --verbosity-level info --target-ecosystem ${GAIA_TARGET_ECOSYSTEM} --enable-feature ${GAIA_ENABLE_FEATURE}

#
# actually, the mscode-cpp extension fail to install by itself, so we provide a temporary archive
#
#RUN cd ../.. \
# && wget https://github.com/microsoft/vscode-cpptools/releases/download/0.29.0-insiders/cpptools-linux.vsix

# inject the LABSIM SSE VSCode workspace
COPY --chown=labsim:labsim distro/linux-gcc-dev-extern/labsim.code-workspace .

