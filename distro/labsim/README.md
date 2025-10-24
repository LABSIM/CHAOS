# CHAOS distro description

> *container stack* : [Podman](https://podman.io/) Engine(CLI) or Docker CEE 
>
> *fullname* : ***LABSIM distros - Debian Linux & GCC/LLVM***
>
> *author* : Nawfel KINANI - DTIS/ICNA

## Independant build targets

- base [*Debian:bookworm*](https://hub.docker.com/_/debian)
  - [*buildpack-deps:bookworm-curl*](https://hub.docker.com/_/buildpack-deps)
    - [*buildpack-deps:bookworm-scm*](https://hub.docker.com/_/buildpack-deps)
      - [*buildpack-deps:bookworm*](https://hub.docker.com/_/buildpack-deps)  
        - => **labsim-base-llvm-bookworm** *(LLVM 19)* 
          - => **labsim-devcontainer-llvm-bookworm**
        - [*gcc:14.1.0-bookworm*](https://hub.docker.com/_/gcc)
          - => **labsim-base-gcc-bookworm**
            - => **labsim-devcontainer-gcc-bookworm**
- base [*Debian:trixie*](https://hub.docker.com/_/debian)
  - from [*buildpack-deps:trixie-curl*](https://hub.docker.com/_/buildpack-deps)
    - from [*buildpack-deps:trixie-scm*](https://hub.docker.com/_/buildpack-deps)
      - from [*buildpack-deps:trixie*](https://hub.docker.com/_/buildpack-deps)
        - => **labsim-base-llvm-trixie** *(LLVM 20)*
          - => **labsim-devcontainer-llvm-trixie**
        - from [*gcc:15.2.0-trixie*](https://hub.docker.com/_/gcc)
          - => **labsim-base-gcc-trixie**
            - => **labsim-devcontainer-gcc-trixie**
