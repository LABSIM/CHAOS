# CHAOS

## Prerequisites

- Windows (>=7) :
  - [Docker Desktop](https://www.docker.com/products/docker-desktop)
  - [BuildKit](https://docs.docker.com/develop/develop-images/build_enhancements/#to-enable-buildkit-builds)
  - Activate WSL2 **required** :
    -  [WSL](https://docs.microsoft.com/fr-fr/windows/wsl/install-win10)
    -  [Update WSL2](https://docs.microsoft.com/fr-fr/windows/wsl/install-win10#update-to-wsl-2)
    -  [Docker WSL2 Backend](https://docs.docker.com/docker-for-windows/wsl/#install)
  - [VisualStudio Code](https://code.visualstudio.com/)

- Ubuntu Linux (every LTS >= 18.04):
  - [DockerCE + DockerCLI + Containerd](https://docs.docker.com/engine/install/ubuntu/#install-using-the-repository)
  - [MicroK8s](https://ubuntu.com/kubernetes/install#single-node) _(Kubernetes for Ubuntu)_
  - [Kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/#install-using-native-package-management) _(Kubernetes CLI)_
  - [BuildKit](https://docs.docker.com/develop/develop-images/build_enhancements/#to-enable-buildkit-builds)
  - [VisualStudio Code](https://code.visualstudio.com/)

## Quick start

### Building our devcontainer

Export secret info to enable 2FA access for git + container ! For further informations, [*see here*](https://help.github.com/en/github/authenticating-to-github/creating-a-personal-access-token-for-the-command-line)

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

then, from your local dev directory, prompt a PowerShell & run :

  ```console
  git clone "https://$(cat C:/your/local/secret/path/github_username.txt):$(cat C:/your/local/secret/path/github_token.txt)@github.com/LABSIM/CHAOS.git"
  ```

dir into your local CHAOS root :
  
  ```console
  cd CHAOS/
  ```

Finally, build our dev-container base image labsim-gcc-dev-extern:latest

  ```console
  docker buildx build \
                --no-cache \
                --progress=full \
                --load \
                --secret id=GITHUB_USERNAME,src=your/local/secret/path/github_username.txt \
                --secret id=GITHUB_TOKEN,src=your/local/secret/path/github_token.txt \
                --builder "$(docker buildx create --driver-opt env.BUILDKIT_STEP_LOG_MAX_SIZE=104857600)" \
                -f distro/linux-gcc-dev-extern/Dockerfile \
                --tag labsim-gcc-dev-extern:latest \
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

So now you should have a labsim-gcc-dev-extern:latest container ready to run ! Launch it with the following :

  ```console
  docker run --rm -it labsim-gcc-dev-extern:latest
  ```

& check the GAIA configuration with :

  ```console
  [labsim@labsim-gcc-dev-extern:latest]$ gaia
  ```

### Configuring VSCode IDE

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
