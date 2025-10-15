# CHAOS distro description

> *container stack* : [Podman](https://podman.io/) Engine(CLI) or Docker CEE 
>
> *fullname* : ***LABSIM distros - Debian Linux & GCC/LLVM***
>
> *author* : Nawfel KINANI - DTIS/ICNA

## Independant build targets

1. GCC Toolchain
   1. **labsim-base-gcc-bookworm**
      - from [*gcc:14.1.0-bookworm*](https://hub.docker.com/_/gcc)
         - from [*buildpack-deps:bookworm*](https://hub.docker.com/_/buildpack-deps)
            - from [*buildpack-deps:bookworm-scm*](https://hub.docker.com/_/buildpack-deps)
               - from [*buildpack-deps:bookworm-curl*](https://hub.docker.com/_/buildpack-deps)
                  - base [*Debian:bookworm*](https://hub.docker.com/_/debian)
   2. **labsim-base-gcc-trixie**
      - from [*gcc:15.2.0-trixie*](https://hub.docker.com/_/gcc)
         - from [*buildpack-deps:trixie*](https://hub.docker.com/_/buildpack-deps)
            - from [*buildpack-deps:trixie-scm*](https://hub.docker.com/_/buildpack-deps)
               - from [*buildpack-deps:trixie-curl*](https://hub.docker.com/_/buildpack-deps)
                  - base [*Debian:trixie*](https://hub.docker.com/_/debian)
   3. **labsim-devcontainer-gcc-bookworm**
      - from *labsim-base-gcc-bookworm*
   4. **labsim-devcontainer-gcc-trixie**
      - from *labsim-base-gcc-trixie*
2. LLVM Toolchain
   1. **labsim-base-llvm-bookworm**
      - from [*buildpack-deps:bookworm-scm*](https://hub.docker.com/_/buildpack-deps)
         - from [*buildpack-deps:bookworm-curl*](https://hub.docker.com/_/buildpack-deps)
            - base [*Debian:bookworm*](https://hub.docker.com/_/debian)
   2. **labsim-devcontainer-llvm-bookworm**
      - from *labsim-base-llvm-bookworm*
