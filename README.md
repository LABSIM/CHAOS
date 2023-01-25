![ONERA](https://www.onera.net/logo-onera-ident.jpg "Logo ONERA")

# CHAOS

Directly jump to corresponding main section:
- [Prerequisites](#prerequisites)
- [Quick start](#quick-start)
- [External links](#external-links)
- [Troubleshooting](#troubleshooting)
- [Bonus](#bonus)

## Prerequisites

- Windows: **>= 10 (with build >= 19041)**
  - [Git](https://git-scm.com/)
  - [WSL2](https://docs.microsoft.com/fr-fr/windows/wsl/install)
  - [Docker Desktop](https://www.docker.com/products/docker-desktop)
  - [BuildKit](https://docs.docker.com/develop/develop-images/build_enhancements/#to-enable-buildkit-builds)
  - [Docker WSL2 Backend](https://docs.docker.com/desktop/windows/wsl/)
  - IDE: **at least one**
     - [VisualStudio Code](https://code.visualstudio.com/)

- Ubuntu Linux: **every LTS >= 18.04**
  - [Git](https://git-scm.com/)
  - [DockerCE/EE](https://docs.docker.com/engine/install/ubuntu/#install-using-the-repository)
  - [MicroK8s](https://ubuntu.com/kubernetes/install#single-node) _(Kubernetes for Ubuntu)_
  - [Kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/#install-using-native-package-management) _(Kubernetes CLI)_
  - [BuildKit](https://docs.docker.com/develop/develop-images/build_enhancements/#to-enable-buildkit-builds)
  - IDE: **at least one**
     - [VisualStudio Code](https://code.visualstudio.com/)

## Quick start

Directly jump to corresponding sub-section:

1. [Clone CHAOS](#1-clone-chaos)
2. [Prepare the builder driver](#2-prepare-the-builder-driver)
2. [Build the container](#3-build-the-container)
4. [Configure your preferred IDE](#4-configure-your-preferred-ide)
   - [VSCode](#51-vscode)

### 1. Clone CHAOS

simply clone CHAOS sources into your local dev directory :

```console
[user@localhost]$ git -C /your/local/dev/directory clone https://github.com/LABSIM/CHAOS.git
```

### 2. Prepare the builder driver 

the build log may be too heavy for the default builder driver so, if recquired, run the following command to increase the log builder setting :

```console
[user@localhost]$ docker buildx create --driver docker-container --driver-opt env.BUILDKIT_STEP_LOG_MAX_SIZE=1000000000 --bootstrap --use
```

### 3. Build the container

first of all, dir into your freshly cloned CHAOS root :
  
```console
[user@localhost]$ cd /your/local/dev/directory/CHAOS/
```

export secret info to enable 2FA access for git + container ! For further informations, [*see here*](https://help.github.com/en/github/authenticating-to-github/creating-a-personal-access-token-for-the-command-line) 

```PowerShell
PS> Write-Output "your_super_secret_github_username" | Out-File -append -encoding ASCII "C:/your/local/secret/path/github_username.txt"
PS> Write-Output "your_super_secret_github_token" | Out-File -append -encoding ASCII "C:/your/local/secret/path/github_token.txt"
```

or

```console
[user@localhost]$ echo 'your_super_secret_github_username' > /your/local/secret/path/github_username.txt
[user@localhost]$ echo 'your_super_secret_github_token' > /your/local/secret/path/github_token.txt
```

then, lauch the docker buildx process for our container `<chaos-target>:<chaos-version>`

```console
[user@localhost]$ docker buildx build --no-cache --load --secret id=GITHUB_USERNAME,src=your/local/secret/path/github_username.txt --secret id=GITHUB_TOKEN,src=your/local/secret/path/github_token.txt --file distro/docker/Dockerfile --target <chaos-target> --tag <chaos-target>:<chaos-version>
```
> by convention, we advise :
> - `<chaos-target>` == CHAOS build target name
> - `<chaos-version>` == CHAOS build version, **a good rule of thumbs should be that it matched the intended GAIA Simulation Software Ecosystem (SSE) version**, see `<gaia-sse-version>` under
>
> available `<chaos-target>` : 
> - **labsim-base-gcc-bullseye** : a Debian Bullseye Linux distro with a GNU GCC compiler environment whithout SSE
> - **labsim-devcontainer-gcc-bullseye** : a Debian Bullseye Linux distro with a GNU GCC compiler environment shipped with the desired SSE
> - **labsim-base-llvm-bullseye** : a Debian Bullseye Linux distro with a LLVM compiler environment whithout SSE
> - **labsim-devcontainer-gcc-bullseye** : a Debian Bullseye Linux distro with a LLVM compiler environment shipped with the desired SSE

> actually, the default GAIA SSE is configured to be the v.[2.0.0](https://github.com/LABSIM/GAIA/tree/master/ecosystem/2.0.0) with features `dev,sf,sb`, but they can be configured through theses *additionnal* args :
>
> ```console
> --build-arg GAIA_TARGET_ECOSYSTEM=<gaia-sse-version>
> --build-arg GAIA_ENABLE_FEATURE=<gaia-sse-feature-A>,<gaia-sse-feature-B>,<gaia-sse-feature-N>
> ```
>
> for a complete list of available `<gaia-sse-version>` & `<gaia-sse-feature>`, [*see here*](https://github.com/LABSIM/GAIA/tree/master/ecosystem)

> furthermore, github tokens are temporary loaded during the build stage via the secret mount mechanism, more informations [*here*](https://docs.docker.com/engine/reference/commandline/buildx_build/#secret)

so now you should have a `<chaos-target>:<chaos-version>` container loaded into your local registry & ready to run ! Launch it with the following :

```console
[user@localhost]$ docker run --rm -it <chaos-target>:<chaos-version>
```

& check the GAIA configuration, if any, with :

```console
[labsim@<chaos-target>:<chaos-version>]$ gaia
```

don't forget to exit our running container :

```console
[labsim@<chaos-target>:<chaos-version>]$ exit
```

### 4. Configure your preferred IDE
  
#### 4.1. VSCode

Then, if you want to dev from the inside of our freshly build container, do :

1. Open VSCode, File > Open Folder... > Navigate to CHAOS dir > [_Enter_]
2. Install the following extensions (shortcut: [Ctrl]+[Shift]+[X]) :
   - [Docker](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-docker) : ms-azuretools.vscode-docker
   - [Kubernetes](https://marketplace.visualstudio.com/items?itemName=ms-kubernetes-tools.vscode-kubernetes-tools) : ms-kubernetes-tools.vscode-kubernetes-tools
   - [Remote dev](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.vscode-remote-extensionpack) : ms-vscode-remote.vscode-remote-extensionpack
   - *BONUS!* [Material Theme](https://marketplace.visualstudio.com/items?itemName=Equinusocio.vsc-material-theme) : Equinusocio.vsc-material-theme
3. Update the `image` field of the .devcontainer/devcontainer.json configuration file to be `<chaos-target>:<chaos-version>`
4. Press [_F1_] & type ```Remote-Containers: Reopen in Container```, [_Enter_]
5. Open the worskspace when prompted to. Should pop in the lower right corner
>  **HACK** : If an error message poped up, well... It seems that the cpptool extension is buggy from inside a container, so we must force/install it from package :
>   - press [_F1_] & type ```Extensions: Install from VSIX...```, [_Enter_]
>   - navigate to ```/labsim/dev/``` directory, then select the ```cpptools-linux.vsix```
>   - reload extensions as prosposed
6. *Happy Coding !*

## External links

> development containers specification, [*see here*](https://containers.dev/)

> devcontainer.json format details, [*see here*](https://containers.dev/implementors/json_reference/)

> VSCode devcontainer documentation, [*see here*](https://code.visualstudio.com/docs/remote/containers)


## Troubleshooting

| Bug/Problem | Advice |
| :--: | :-- |
| - *Win10* - suuuuuper slow internet speed | 1. run a powershell as admin <br/>2. [run this command](https://github.com/docker/for-win/issues/698#issuecomment-314902326) <br/>3. reboot host <br/>4. clean & purge docker data |

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
