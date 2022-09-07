# CHAOS

Directly jump to corresponding main section:
- [Prerequisites](#prerequisites)
- [Quick start](#quick-start)
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
2. [Build the labsim-base](#3-build-the-labsim-base)
3. [Build the labsim-devcontainer](#4-build-the-labsim-devcontainer)
4. [Configure your preferred IDE](#5-configure-your-preferred-ide)
   - [VSCode](#51-vscode)

### 1. Clone CHAOS

simply clone CHAOS sources into your local dev directory :

  ```console
  git -C /your/local/dev/directory clone "https://$(cat C:/your/local/secret/path/github_username.txt):$(cat C:/your/local/secret/path/github_token.txt)@github.com/LABSIM/CHAOS.git"
  ```

### 2. Prepare the builder driver 

the build log may be too heavy for the default builder driver so, if recquired, run the following command to increase the log builder setting :

  ```console
  docker buildx create --driver docker-container --driver-opt env.BUILDKIT_STEP_LOG_MAX_SIZE=1000000000 --bootstrap --use
  ```

### 3. Build the labsim-base

first of all, dir into your freshly cloned CHAOS root :
  
  ```console
  cd /your/local/dev/directory/CHAOS/
  ```

then, lauch the docker buildx process for our base image labsim-base:2.0.0

  ```console
  docker buildx build \
                --no-cache \
                --load \
                --file distro/docker/Dockerfile \
                --target labsim-base \
                --tag local/labsim-base:2.0.0 \
                .
  ```

So now you should have a labsim-base:2.0.0 container ready to run ! Launch it with the following :

  ```console
  docker run --rm -it labsim-base:2.0.0
  ```

don't forget to exit our running container :

  ```console
  [labsim@labsim-base:2.0.0]$ exit
  ```

### 4. Build the labsim-devcontainer

export secret info to enable 2FA access for git + container ! For further informations, [*see here*](https://help.github.com/en/github/authenticating-to-github/creating-a-personal-access-token-for-the-command-line)

 ```PowerShell
 PS> Write-Output "your_super_secret_github_username" \
       | Out-File -append -encoding ASCII "C:/your/local/secret/path/github_username.txt"
 PS> Write-Output "your_super_secret_github_token" <br/> \
       | Out-File -append -encoding ASCII "C:/your/local/secret/path/github_token.txt"
 ```

or

 ```console
 [user@localhost]$ echo 'your_super_secret_github_username' > /your/local/secret/path/github_username.txt
 [user@localhost]$ echo 'your_super_secret_github_token' > /your/local/secret/path/github_token.txt
 ```

then, lauch the docker buildx process for our labsim devcontainer image labsim-devcontainer:2.0.0

  ```console
  docker buildx build \
                --no-cache \
                --load \
                --secret id=GITHUB_USERNAME,src=your/local/secret/path/github_username.txt \
                --secret id=GITHUB_TOKEN,src=your/local/secret/path/github_token.txt \
                --file distro/docker/Dockerfile \
                --target labsim-devcontainer \
                --tag labsim-devcontainer:2.0.0 \
                .
  ```

> actually, the default GAIA Ecosystem is ```LABSIM-2.0.0``` with features ```dev,sf,sb``` but they can be configured through theses *additionnal* args :
>
> ```console
> --build-arg GAIA_TARGET_ECOSYSTEM=<ecosystem-name> 
> --build-arg GAIA_ENABLE_FEATURE=<feature-A>,<feature-B>,<feature-N>
> ```
>
> for a complete list of available GAIA ecosystems & features, [*see here*](https://github.com/LABSIM/GAIA/tree/master/ecosystem)

So now you should have a labsim-devcontainer:2.0.0 container ready to run ! Launch it with the following :

  ```console
  docker run --rm -it labsim-devcontainer:2.0.0
  ```

& check the GAIA configuration with :

  ```console
  [labsim@labsim-devcontainer:2.0.0]$ gaia
  ```

don't forget to exit our running container :

  ```console
  [labsim@labsim-devcontainer:2.0.0]$ exit
  ```

### 5. Configure your preferred IDE
  
#### 5.1. VSCode

Then, if you want to dev from the inside of our freshly build container, do :

1. Open VSCode, File > Open Folder... > Navigate to CHAOS dir > [_Enter_]
2. Install the following extensions (shortcut: [Ctrl]+[Shift]+[X]) :
   - [Docker](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-docker) : ms-azuretools.vscode-docker
   - [Kubernetes](https://marketplace.visualstudio.com/items?itemName=ms-kubernetes-tools.vscode-kubernetes-tools) : ms-kubernetes-tools.vscode-kubernetes-tools
   - [Remote dev](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.vscode-remote-extensionpack) : ms-vscode-remote.vscode-remote-extensionpack
   - *BONUS!* [Material Theme](https://marketplace.visualstudio.com/items?itemName=Equinusocio.vsc-material-theme) : Equinusocio.vsc-material-theme
3. Press [_F1_] & type ```Remote-Containers: Reopen in Container```, [_Enter_]
4. Open the worskspace when prompted to. Should pop in the lower right corner (?) **HACK** If an error message poped up, well... It seems that the cpptool extension is buggy from inside a container, so we must force/install it from package :
   - press [_F1_] & type ```Extensions: Install from VSIX...```, [_Enter_]
   - navigate to ```/labsim/dev/``` directory, then select the ```cpptools-linux.vsix```
   - reload extensions as prosposed
5. *Happy Coding !*

## Troubleshooting

| Bug/Problem | Advice |
| :--: | :-- |
| - *Win10* - suuuuuper slow internet speed | 1. run a powershell as admin <br/>2. [run this command](https://github.com/docker/for-win/issues/698#issuecomment-314902326) <br/>3. reboot host <br/>4. clean & purge docker data |

## Bonus

> official documentation, [*see here*](https://code.visualstudio.com/docs/remote/containers)

- clean all local images: `docker rmi -f $(docker images -a -q)`
- list all local images: `docker image ls`
- run interactive shell: `docker run --rm -it {container}:{tag}`
- see running container stats from shell: `docker stats`
- *! CAUTION !* full cleanup: `docker system prune`

## License

Code licensed under the [GNU GPLv3](COPYING).
## LABSIM Team members (*LAB*oratoire de *SIM*ulation)

Nawfel KINANI

> ![nkinani](https://avatars0.githubusercontent.com/u/4352738?s=460&u=4161f3b9e0658ec0213a548c459ddd0904a518e8&v=4)
>
> - lead dev
> - < nawfel.kinani at onera.fr >
> - DTIS/ICNA
> - Centre de Salon de provence - BA 701 FR-13661 SALON CEDEX AIR

![ONERA](https://www.fondamenti.fr/assets/img/portfolios/Onera-bloc-marque.png "Logo ONERA")
