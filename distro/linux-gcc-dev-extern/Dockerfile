# syntax = docker/dockerfile:experimental

# -> Debian:buster 
#  -> buildpack-deps:buster-curl 
#   -> buildpack-deps:buster-scm 
#    -> buildpack-deps:buster 
#     -> gcc:10.1.0
FROM gcc:10.1.0 as labsim-dev

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
ARG GAIA_TARGET_ECOSYSTEM
ARG GAIA_ENABLE_FEATURE

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
 && apt-get autoremove -y \
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

# add labsim user
RUN useradd --no-log-init --user-group --create-home --shell /bin/bash labsim
USER labsim

# setup LABSIM Simulation Software Ecosysten : create dirs, clone sources from github, then integrate gaia features & VSCode workspace
# WORKDIR /labsim/dev/olympiens
# WORKDIR /labsim/dev/titans
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
 && git clone https://$(cat /run/secrets/GITHUB_USERNAME):$(cat /run/secrets/GITHUB_TOKEN)@github.com/LABSIM/THETYS.git titans/THETYS \
 && git clone https://$(cat /run/secrets/GITHUB_USERNAME):$(cat /run/secrets/GITHUB_TOKEN)@github.com/LABSIM/OCEAN.git titans/OCEAN \
 && git clone https://$(cat /run/secrets/GITHUB_USERNAME):$(cat /run/secrets/GITHUB_TOKEN)@github.com/LABSIM/RHEA.git titans/RHEA \
 && git clone https://$(cat /run/secrets/GITHUB_USERNAME):$(cat /run/secrets/GITHUB_TOKEN)@github.com/LABSIM/KRONOS.git titans/KRONOS \
 && git clone https://$(cat /run/secrets/GITHUB_USERNAME):$(cat /run/secrets/GITHUB_TOKEN)@github.com/LABSIM/ZEUS.git olympiens/ZEUS \
 && cd titans/GAIA \
    #
    # check mandatory args
    #
    : "${GAIA_TARGET_ECOSYSTEM:?GAIA target-ecosystem argument needs to be set and non-empty.}" \
    : "${GAIA_ENABLE_FEATURE:?GAIA enable-feature argument needs to be set and non-empty.}" \
    #
    # bootstrap GAIA & cleanup temporary files
    #
 && chmod +x bootstrap-gaia.sh \
 && ./bootstrap-gaia.sh --verbosity-level debug --target-ecosystem ${GAIA_TARGET_ECOSYSTEM} --enable-feature ${GAIA_ENABLE_FEATURE} \
 && rm -rf /tmp \
    #
    # actually, the mscode-cpp extension fail to install by itself, so we provide a temporary archive
    #
 && wget https://github.com/microsoft/vscode-cpptools/releases/download/0.29.0-insiders/cpptools-linux.vsix

# inject the LABSIM SSE VSCode workspace
COPY distro/linux-gcc-dev-extern/labsim.code-workspace .