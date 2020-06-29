# CHAOS

## Quick Start

From your local dev directory, prompt a term & run :

- Linux :

  ```console
  [user@localhost]$ git clone https://github.com/LABSIM/CHAOS.git
  [user@localhost]$ cd CHAOS/
  ```

- Windows :

  ```console
  PS> git clone https://github.com/LABSIM/CHAOS.git
  PS> cd CHAOS/
  ```

Export secret info to enable 2FA devcontainer access !

- Linux :

  ```console
  [user@localhost]$ echo 'your_super_secret_github_username' > your/local/secret/path/github_username.txt
  [user@localhost]$ echo 'your_super_secret_github_token' > your/local/secret/path/github_token.txt
  ```

- Windows :

  ```console
  PS> Write-Output "your_super_secret_github_username" \
        | Out-File -append -encoding ASCII "your/local/secret/path/github_username.txt"
  PS> Write-Output "your_super_secret_github_token" <br/> \
        | Out-File -append -encoding ASCII "your/local/secret/path/github_token.txt"
  ```

> for more info, [*see here*](https://help.github.com/en/github/authenticating-to-github/creating-a-personal-access-token-for-the-command-line)

Install docker desktop & enable BuildKit feature

- [Docker Desktop](https://www.docker.com/products/docker-desktop)
- [BuildKit](https://docs.docker.com/develop/develop-images/build_enhancements/#to-enable-buildkit-builds)
- Activate WSL2 - _**Windows only**_ / **required** :
  -  [WSL](https://docs.microsoft.com/fr-fr/windows/wsl/install-win10)
  -  [Update WSL2](https://docs.microsoft.com/fr-fr/windows/wsl/install-win10#update-to-wsl-2)
  -  [Docker WSL2 Backend](https://docs.docker.com/docker-for-windows/wsl/#install)

Finally, dir into your local CHAOS root & build container :

- Linux :

  ```console
  [user@localhost]$ docker build \
                      --no-cache \
                      --progress=plain \
                      --build-arg GAIA_TARGET_ECOSYSTEM={ecosystem} \
                      --build-arg GAIA_ENABLE_FEATURE={feature_1},{feature_2},...,{feature_N} \
                      --secret id=GITHUB_USERNAME,src=your/secret/path/github_username.txt \
                      --secret id=GITHUB_TOKEN,src=your/secret/path/github_token.txt \
                      -f distro/{container}/Dockerfile \
                      --tag labsim-{container}:{tag} \
                      .
  ```

- Windows :

  ```console
  PS> docker build \
        --no-cache \
        --progress=plain \
        --build-arg GAIA_TARGET_ECOSYSTEM={ecosystem} \
        --build-arg GAIA_ENABLE_FEATURE={feature_1},{feature_2},...,{feature_N} \
        --secret id=GITHUB_USERNAME,src=your/secret/path/github_username.txt \
        --secret id=GITHUB_TOKEN,src=your/secret/path/github_token.txt \
        -f distro/{container}/Dockerfile \
        --tag labsim-{container}:{tag} \
        .
  ```
> for a list of available GAIA ecosystems & features, [*see here*](https://github.com/LABSIM/GAIA/tree/master/ecosystem)

So now you should have a labsim-{container}:{tag} container ready to run ! Launch it with the following :

- Linux :

  ```console
  [user@localhost]$ docker run --rm -it labsim-{container}:{tag}
  ```

- Windows :

  ```console
  PS> docker run --rm -it labsim-{container}:{tag}
  ```

& check the GAIA configuration with :

- Linux@Docker :

  ```console
  [root@labsim-{container}:{tag}]$ gaia
  ```

Then, if you want to dev from the inside of our freshly build container, do :

1. Install [VisualStudio Code](https://code.visualstudio.com/)
2. Open VSCode
   - then "File" => "Open Workspace" => navigate to your CHAOS_ROOT directory & select the [labsim-dev.code-workspace](labsim-dev.code-workspace) configuration file
   - install the following VSCode extensions (shortcut: [Ctrl]+[Shift]+[X]), normally they should also appear under the "recommended" section :
      -  [Docker](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-docker)
      -  [Kubernetes](https://marketplace.visualstudio.com/items?itemName=ms-kubernetes-tools.vscode-kubernetes-tools)
      -  [Remote dev](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.vscode-remote-extensionpack)
      -  [Material Theme](https://marketplace.visualstudio.com/items?itemName=Equinusocio.vsc-material-theme), bonus ;)
   - press [_F1_] & type ```Remote-Containers: Reopen in Container```, [_Enter_]
3. *Happy Coding !*

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

## License

Code licensed under the [GNU GPLv3](COPYING).
