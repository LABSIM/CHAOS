# syntax = docker/dockerfile:experimental

# -> Debian:bullseye 
#  -> buildpack-deps:bullseye-curl 
#   -> buildpack-deps:bullseye-scm 
#    -> buildpack-deps:bullseye 
#     -> gcc:11.2.0-bullseye
FROM gcc:11.2.0-bullseye as labsim-dev

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

# mandatory argument
ARG GAIA_TARGET_ECOSYSTEM="LABSIM-2.0.0"
ARG GAIA_ENABLE_FEATURE="dev,sf,sb"

# avoid warnings by switching to noninteractive
ENV DEBIAN_FRONTEND=noninteractive

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
ENV DEBIAN_FRONTEND=dialog

# timezone & env locales
ENV TZ "Europe/Paris"
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8

# add & set labsim user
RUN useradd --no-log-init --user-group --create-home --shell /bin/bash labsim
USER labsim

# setup LABSIM Simulation Software Ecosysten : create dir, clone sources from github, then integrate gaia features & VSCode workspace
WORKDIR /home/labsim/dev
#
# mount secrets
#
RUN --mount=type=secret,mode=0444,id=GITHUB_USERNAME,required \
    --mount=type=secret,mode=0444,id=GITHUB_TOKEN,required \
    #
    # clone sources
    #
    git clone https://$(cat /run/secrets/GITHUB_USERNAME):$(cat /run/secrets/GITHUB_TOKEN)@github.com/LABSIM/GAIA.git titans/GAIA \
 && git clone https://$(cat /run/secrets/GITHUB_USERNAME):$(cat /run/secrets/GITHUB_TOKEN)@github.com/LABSIM/OURANOS.git titans/OURANOS \
 && git clone --recurse-submodules https://$(cat /run/secrets/GITHUB_USERNAME):$(cat /run/secrets/GITHUB_TOKEN)@github.com/LABSIM/THETYS.git titans/THETYS \
 && git clone https://$(cat /run/secrets/GITHUB_USERNAME):$(cat /run/secrets/GITHUB_TOKEN)@github.com/LABSIM/OCEAN.git titans/OCEAN \
 && git clone https://$(cat /run/secrets/GITHUB_USERNAME):$(cat /run/secrets/GITHUB_TOKEN)@github.com/LABSIM/RHEA.git titans/RHEA \
 && git clone https://$(cat /run/secrets/GITHUB_USERNAME):$(cat /run/secrets/GITHUB_TOKEN)@github.com/LABSIM/KRONOS.git titans/KRONOS \
 && git clone https://$(cat /run/secrets/GITHUB_USERNAME):$(cat /run/secrets/GITHUB_TOKEN)@github.com/LABSIM/ZEUS.git olympiens/ZEUS \
    #
    # bootstrap GAIA
    #
 && cd titans/GAIA \
 && chmod +x bootstrap-gaia.sh \
 && ./bootstrap-gaia.sh --verbosity-level debug --target-ecosystem ${GAIA_TARGET_ECOSYSTEM} --enable-feature ${GAIA_ENABLE_FEATURE}
    #
    # actually, the mscode-cpp extension fail to install by itself, so we provide a temporary archive
    #
#  && cd ../.. \
#  && wget https://github.com/microsoft/vscode-cpptools/releases/download/0.29.0-insiders/cpptools-linux.vsix

# inject the LABSIM SSE VSCode workspace
COPY --chown=labsim:labsim distro/linux-gcc-dev-extern/labsim.code-workspace .
