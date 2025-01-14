# CHAOS

![ONERA](https://www.onera.net/logo-onera-ident.jpg "Logo ONERA")

Directly jump to corresponding main section:

- [Prerequisites](#prerequisites)
- [Usage](#usage)
- [External links](#external-links)
- [Troubleshooting](#troubleshooting)
- [Bonus](#bonus)

## Prerequisites

- Windows: **>= 10 (with build >= 19041)**
  - [Git](https://git-scm.com/)
  - enable [WSL2](https://docs.microsoft.com/fr-fr/windows/wsl/install) feature
  - Container engine : **at least one**
    - [Docker Desktop](https://www.docker.com/products/docker-desktop) + [BuildKit](https://docs.docker.com/develop/develop-images/build_enhancements/#to-enable-buildkit-builds) + activate the [WSL2 Backend](https://docs.docker.com/desktop/windows/wsl/) for Docker Desktop
    - _(preferred)_ [Podman](https://podman.io/) Engine(CLI) or Desktop
  - IDE: **at least one**
    - [VisualStudio Code](https://code.visualstudio.com/)

- Ubuntu Linux: **every LTS >= 18.04**
  - [Git](https://git-scm.com/)
  - Container engine : **at least one**
    - [DockerCE/EE](https://docs.docker.com/engine/install/ubuntu/#install-using-the-repository) + [BuildKit](https://docs.docker.com/develop/develop-images/build_enhancements/#to-enable-buildkit-builds)
    - _(preferred)_ [Podman](https://podman.io/) Engine(CLI) or Desktop
  - IDE: **at least one**
    - [VisualStudio Code](https://code.visualstudio.com/) + specific [Podman's IDE configuration](https://blog.while-true-do.io/podman-configure-vscode-for-containers/)
  - _(optional)_ [MicroK8s](https://ubuntu.com/kubernetes/install#single-node) : Kubernetes for Ubuntu
  - _(optional)_ [Kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/#install-using-native-package-management) : Kubernetes CLI

> see [here](https://github.com/containers) or [there](https://opencontainers.org/) for more info about the Open Containers Initiative (OCI).

## Usage

Directly jump to corresponding sub-section:

1. [Clone](#1-clone-chaos)
2. [Prepare](#2-prepare-the-environment)
3. [Build](#3-build-the-container)
   - [Docker](#31-docker-stack)
   - [OCI - Podman](#32-podman-stack)
4. [Configure](#4-configure-your-preferred-ide)
   1. [VSCode](#41-vscode)

### 1. Clone CHAOS

simply clone CHAOS repo into your local dev directory :

```console
[user@hostname]$ git -C /your/local/dev/directory clone https://github.com/LABSIM/CHAOS.git
```

### 2. Prepare the environment

first of all, dir into your freshly cloned CHAOS root :
  
```console
[user@hostname]$ cd /your/local/dev/directory/CHAOS/
```

export secret info *(personal access token)* to enable git 2FA from a container ! For further informations, [*see here*](https://help.github.com/en/github/authenticating-to-github/creating-a-personal-access-token-for-the-command-line)


```console
[user@hostname]$ echo 'your_super_secret_github_username' > /your/local/secret/path/github_username.txt
[user@hostname]$ echo 'your_super_secret_github_token' > /your/local/secret/path/github_token.txt
```

or... 

```PowerShell
PS> Write-Output "your_super_secret_github_username" | Out-File -append -encoding ASCII "C:\your\local\secret\path\github_username.txt"
PS> Write-Output "your_super_secret_github_token" | Out-File -append -encoding ASCII "C:\your\local\secret\path\github_token.txt"
```

then, we'll lauch the build stage for our container `<chaos-target>:<chaos-version>`

> furthermore, private github tokens are temporary loaded during the build stage via the secret mount mechanism, more informations [_here_](https://docs.docker.com/engine/reference/commandline/buildx_build/#secret)

### 3. Build the container

depending on your container engine, available `<chaos-target>` &  build procedure may be subject to some minor changes.

by convention, we advise :

- `<chaos-section>` == CHAOS high-level section name containing multiple target foreach *project*
- `<chaos-target>` == CHAOS specific build target name
- `<chaos-version>` == CHAOS build version, **a good rule of thumbs should be that it matched the intended GAIA Simulation Software Ecosystem (SSE) version**, see under

actually, the default GAIA SSE is configured to be the v.`2.0.1` with features `dev,sf,sb`, but they can be configured through theses _additionnal_ args in any of the folowwing container engine :

```console
--build-arg GAIA_TARGET_ECOSYSTEM=<gaia-sse-version>
--build-arg GAIA_ENABLE_FEATURE=<gaia-sse-feature-A>,<gaia-sse-feature-B>,<gaia-sse-feature-N>
```

for a complete list of available each `<gaia-sse-version>` & `<gaia-sse-feature>`, see the LABSIM private GAIA repository [_here_](https://github.com/LABSIM/GAIA/tree/master/ecosystem)

#### 3.1. Docker stack

> **MAY** be required
> 
> the build log may be too heavy for the default builder driver so, if required, run the following command to increase the log builder setting :
> 
> ```console
> [user@hostname]$ docker buildx create --driver docker-container --driver-opt env.BUILDKIT_STEP_LOG_MAX_SIZE=1000000000 --bootstrap --use
> ```

start by running the following command

```console
[user@hostname]$ docker build --no-cache --load --secret id=GITHUB_USERNAME,src=your/local/secret/path/github_username.txt --secret id=GITHUB_TOKEN,src=your/local/secret/path/github_token.txt --file distro/<chaos-section>/docker/Dockerfile --target <chaos-target> --tag <chaos-target>:<chaos-version> .
```

available `<chaos-target>` for each `<chaos-section>` are :

 1. [LABSIM](distro/labsim/docker/Dockerfile) section (docker multi-stage build) :
    - **labsim-base-gcc-bookworm** target : a Debian Bookworm Linux distro with a GNU GCC compiler environment whithout SSE
    - **labsim-devcontainer-gcc-bookworm** target : a Debian Bookworm Linux distro with a GNU GCC compiler environment shipped with the desired SSE
    - **labsim-base-llvm-bookworm** target : a Debian Bookworm Linux distro with a LLVM compiler environment whithout SSE
    - **labsim-devcontainer-llvm-bookworm** target : a Debian Bookworm Linux distro with a LLVM compiler environment shipped with the desired SSE
 2. [SCHEME-GATEWAY](distro/scheme-gateway/docker/Dockerfile) section (docker multi-stage build) :
    - **scheme-gateway-gcc-bookworm** target : a Debian Bookworm Linux distro with a GNU GCC compiler environment whithout SSE
    - **scheme-gateway-devcontainer-gcc-bookworm** target : a Debian Bookworm Linux distro with a GNU GCC compiler environment shipped with the desired SSE

so now you should have a `<chaos-target>:<chaos-version>` container loaded into your local registry & ready to run ! Launch it with the following :

```console
[user@hostname]$ docker run --rm -it <chaos-target>:<chaos-version>
```

& check the GAIA configuration, if any, with :

```console
[user@hostname]$ gaia
```

don't forget to exit our running container :

```console
[user@hostname]$ exit
```

#### 3.2. Podman stack

```console
[user@hostname]$ podman build --format oci --isolation rootless --no-cache --load --secret id=GITHUB_USERNAME,src=your/local/secret/path/github_username.txt --secret id=GITHUB_TOKEN,src=your/local/secret/path/github_token.txt --file distro/<chaos-section>/oci/<chaos-target>/Containerfile --tag <chaos-target>:<chaos-version> .
```

available `<chaos-target>` for each `<chaos-section>` are :

 1. **LABSIM** section :
    - [labsim-base-gcc-bookworm](distro/labsim/oci/labsim-base-gcc-bookworm/Containerfile) target : a Debian Bookworm Linux distro with a GNU GCC compiler environment whithout SSE
    - [labsim-devcontainer-gcc-bookworm](distro/labsim/oci/labsim-devcontainer-gcc-bookworm/Containerfile) target : a Debian Bookworm Linux distro with a GNU GCC compiler environment shipped with the desired SSE
    - [labsim-base-llvm-bookworm](distro/labsim/oci/labsim-base-llvm-bookworm/Containerfile) target : a Debian Bookworm Linux distro with a LLVM compiler environment whithout SSE
    - [labsim-devcontainer-llvm-bookworm](distro/labsim/oci/labsim-devcontainer-llvm-bookworm/Containerfile) target : a Debian Bookworm Linux distro with a LLVM compiler environment shipped with the desired SSE

so now you should have a `<chaos-target>:<chaos-version>` container loaded into your local registry & ready to run ! Launch it with the following :

```console
[user@hostname]$ podman run --rm -it <chaos-target>:<chaos-version>
```

& check the GAIA configuration, if any, with :

```console
[user@hostname]$ gaia
```

don't forget to exit our running container :

```console
[user@hostname]$ exit
```

### 4. Configure your preferred IDE
  
#### 4.1. VSCode

Then, if you want to dev from the inside of our freshly build container, do :

1. Open VSCode, File > Open Folder... > Navigate to CHAOS dir > [_Enter_]
2. Install the following extensions (shortcut: [Ctrl]+[Shift]+[X]) :
   - [Docker](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-docker) : ms-azuretools.vscode-docker
   - [Kubernetes](https://marketplace.visualstudio.com/items?itemName=ms-kubernetes-tools.vscode-kubernetes-tools) : ms-kubernetes-tools.vscode-kubernetes-tools
   - [Remote dev](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.vscode-remote-extensionpack) : ms-vscode-remote.vscode-remote-extensionpack
   - _BONUS!_ [Material Theme](https://marketplace.visualstudio.com/items?itemName=Equinusocio.vsc-material-theme) : Equinusocio.vsc-material-theme
4. Press [_F1_] & type ```Remote-Containers: Rebuild & Reopen in Container```, select the desired target, [_Enter_]
5. Open the worskspace when prompted to. Should pop in the lower right corner
6. _Happy Coding !_

>**_Iff._** using an LLVM based devcontainer [see here](https://github.com/llvm/llvm-project/tree/main/lldb/tools/lldb-vscode#Installation-Visual-Studio-Code) about how to configure an integrated lldb debugger or, if you are a lazy one, as I am, simply install the [CodeLLDB](https://marketplace.visualstudio.com/items?itemName=vadimcn.vscode-lldb) package from marketplace. But, be advise that it ship it's own LLDB binary so it will squeeze the devcontainer built-in...

> **HACK** : If an error message poped up, well... It seems that the cpptool extension is buggy from inside a container, so we must force/install it from package :
>
>- press [_F1_] & type ```Extensions: Install from VSIX...```, [_Enter_]
>- navigate to ```/labsim/dev/``` directory, then select the ```cpptools-linux.vsix```
>- reload extensions as prosposed

## External links

- development containers specification, [_see here_](https://containers.dev/)

- devcontainer.json format details, [_see here_](https://containers.dev/implementors/json_reference/)

- VSCode devcontainer documentation, [_see here_](https://code.visualstudio.com/docs/remote/containers)


## Troubleshooting

| Bug/Problem | Advice |
| :--: | :-- |
| - _Win10_ - suuuuuper slow internet speed | 1. run a powershell as admin <br/>2. [run this command](https://github.com/docker/for-win/issues/698#issuecomment-314902326) <br/>3. reboot host <br/>4. clean & purge docker data |

## Bonus

| Command | Description |
| :-- | :-- |
| `docker rmi -f $(docker images -a -q)` | clean all local images |
| `docker image ls` | list all local images |
| `docker run --rm -it {container}:{tag}` | run interactive shell |
| `docker stats` | see running container stats from shell |
| `docker system prune --all --force --volumes` | **! CAUTION !** full cleanup |

## License

![GNU GPLv3](https://www.gnu.org/graphics/gplv3-with-text-84x42.png)

See [COPYING](COPYING) file
