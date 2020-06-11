# GAIA

## Overview

Todo

## Quick Start

jump to your config :

- [Standalone Linux](#standalone-linux)
- [Docker Container](#docker)
- _*Windows only*_ - [Windows Subsystem for Linux (WSL)](#wsl)

### Standalone Linux

Run a standard shell from GAIA root directory.

```console
 [user@localhost]$ ./bootstrap-gaia.sh
```

List all available LABSIM software ecosystem.

```console
[user@localhost]$ gaia --list-available
```

> Alternatively for a more complete description of one available LABSIM software ecosystem, run :

```console
[user@localhost]$ gaia --detailled-ecosystem {ecosystem} | more
```

Then, deploy your ecosystem with feature(s) :

```console
[user@localhost]$ gaia \
                    --target-ecosystem {ecosystem} \
                    --enable-feature {feature_A} \
                    --enable-feature {feature_B} \
                    ... \
                    --enable-feature {feature_N}
```

> Alternatively, it could be compacted as follow :

 ```console
 [user@localhost]$ gaia \
                     --target-ecosystem {ecosystem} \
                     --enable-feature {feature_A},{feature_B},...,{feature_N}
```

### WSL

> official documentation, [see here](https://code.visualstudio.com/docs/remote/wsl)

1. Activate WSL1(_required_) : [WSL](https://docs.microsoft.com/fr-fr/windows/wsl/install-win10)
2. Install a WSL distro, for exemple [Ubuntu 20.04 LTS](https://www.microsoft.com/fr-fr/p/ubuntu-2004-lts/9n6svws3rx71). For more distro [see here](https://docs.microsoft.com/fr-fr/windows/wsl/install-win10#install-your-linux-distribution-of-choice)
3. Install Visual Studio Code : [VSCode](https://code.visualstudio.com/)
4. Install VSCode extension :
   - [Docker](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-docker)
   - [Kubernetes](https://marketplace.visualstudio.com/items?itemName=ms-kubernetes-tools.vscode-kubernetes-tools)
   - [Remote dev](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.vscode-remote-extensionpack)
   - [C++](https://marketplace.visualstudio.com/items?itemName=ms-vscode.cpptools)
   - [CMake](https://marketplace.visualstudio.com/items?itemName=ms-vscode.cmake-tools)
   - [Perl](https://marketplace.visualstudio.com/items?itemName=d9705996.perl-toolbox)
   - [INI](https://marketplace.visualstudio.com/items?itemName=DavidWang.ini-for-vscode)
   - [Markdown](https://marketplace.visualstudio.com/items?itemName=DavidAnson.vscode-markdownlint)
   - [Shell](https://marketplace.visualstudio.com/items?itemName=jeff-hykin.better-shellscript-syntax)
   - [Material Theme, bonus ;)](https://marketplace.visualstudio.com/items?itemName=Equinusocio.vsc-material-theme)
5. From VSCode, run a wsl console & start developping as a [Standalone Linux](#standalone-linux) configuration.

### Docker

> official documentation, [see here](https://code.visualstudio.com/docs/remote/containers)

Install docker desktop & enable BuildKit feature

- [Docker Desktop](https://www.docker.com/products/docker-desktop)
- [BuildKit](https://docs.docker.com/develop/develop-images/build_enhancements/#to-enable-buildkit-builds)

If you want to dev from a container :

1. _*Windows only*_ Activate WSL2(_required_) : [WSL](https://docs.microsoft.com/fr-fr/windows/wsl/install-win10)
2. Install Visual Studio Code : [VSCode](https://code.visualstudio.com/)
3. Install VSCode extension :
   - [Docker](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-docker)
   - [Kubernetes](https://marketplace.visualstudio.com/items?itemName=ms-kubernetes-tools.vscode-kubernetes-tools)
   - [Remote dev](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.vscode-remote-extensionpack)
   - [C++](https://marketplace.visualstudio.com/items?itemName=ms-vscode.cpptools)
   - [CMake](https://marketplace.visualstudio.com/items?itemName=ms-vscode.cmake-tools)
   - [Perl](https://marketplace.visualstudio.com/items?itemName=d9705996.perl-toolbox)
   - [INI](https://marketplace.visualstudio.com/items?itemName=DavidWang.ini-for-vscode)
   - [Markdown](https://marketplace.visualstudio.com/items?itemName=DavidAnson.vscode-markdownlint)
   - [Shell](https://marketplace.visualstudio.com/items?itemName=jeff-hykin.better-shellscript-syntax)
   - [Material Theme, bonus ;)](https://marketplace.visualstudio.com/items?itemName=Equinusocio.vsc-material-theme)

Export secret info to enable 2FA container access !

- Linux :

  ```console
  [user@localhost]$ echo 'your_super_secret_github_username' > your/secret/path/github_username.txt
  [user@localhost]$ echo 'your_super_secret_github_token' > your/secret/path/github_token.txt
  ```

- Windows :

  ```console
  PS> Write-Output "your_super_secret_github_username" \
        | Out-File -append -encoding ASCII "your/secret/path/github_username.txt"
  PS> Write-Output "your_super_secret_github_token" <br/> \
        | Out-File -append -encoding ASCII "your/secret/path/github_token.txt"
  ```

> for more info, [see here](https://help.github.com/en/github/authenticating-to-github/creating-a-personal-access-token-for-the-command-line)

Finally, dir into your local GAIA root & build container

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

> Bonus !
>
> - clean all local images : `docker rmi -f $(docker images -a -q)`
> - list all local images: `docker image ls`
> - run interactive shell: `docker run --rm -it {container}:{tag}`

## License

Code licensed under the [GNU GPLv3](COPYING).
