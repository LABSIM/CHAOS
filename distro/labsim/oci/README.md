# CHAOS distro description

> *container stack* : [Podman](https://podman.io/) Engine(CLI) or Desktop 
>
> *fullname* : ***LABSIM distros - Debian Linux & GCC/LLVM***
>
> *author* : Nawfel KINANI - DTIS/ICNA

## Stage build targets

1. GCC Toolchain
   1. **labsim-base-gcc-bookworm**
      - from [*gcc:14.1.0-bookworm*](https://hub.docker.com/layers/library/gcc/14.1.0-bookworm/images/sha256-9bedae387a7618250f14a9ee5a68521cae6f9cd29825e9af2c33d5436205fd92?context=explore)
         - from [*buildpack-deps:bookworm*](https://hub.docker.com/_/buildpack-deps)
            - from [*buildpack-deps:bookworm-scm*](https://hub.docker.com/_/buildpack-deps)
               - from [*buildpack-deps:bookworm-curl*](https://hub.docker.com/_/buildpack-deps)
                  - base [*Debian:bookworm*](https://hub.docker.com/_/debian)
   2. **labsim-devcontainer-gcc-bookworm**
      - from *labsim-base-gcc-bookworm*
2. LLVM Toolchain
   1. **labsim-base-llvm-bookworm**
      - from [*buildpack-deps:bookworm-scm*](https://hub.docker.com/_/buildpack-deps)
         - from [*buildpack-deps:bookworm-curl*](https://hub.docker.com/_/buildpack-deps)
            - base [*Debian:bookworm*](https://hub.docker.com/_/debian)
   2. **labsim-devcontainer-llvm-bookworm**
      - from *labsim-base-llvm-bookworm*
