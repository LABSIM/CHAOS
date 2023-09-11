# CHAOS distro description

> *container stack* : [Docker](https://www.docker.com/) = DockerCE/EE + [BuildKit](https://github.com/moby/buildkit)
>
> *fullname* : ***LABSIM distros - Debian Linux & GCC/LLVM***
>
> *author* : Nawfel KINANI - DTIS/ICNA

## Stage build targets

1. **labsim-base-gcc-bookworm**
   - from [*gcc:13.2.0-bookworm*](https://hub.docker.com/layers/library/gcc/13.2.0-bookworm/images/sha256-9bedae387a7618250f14a9ee5a68521cae6f9cd29825e9af2c33d5436205fd92?context=explore)
      - from [*buildpack-deps:bookworm*](https://hub.docker.com/_/buildpack-deps)
         - from [*buildpack-deps:bookworm-scm*](https://hub.docker.com/_/buildpack-deps)
            - from [*buildpack-deps:bookworm-curl*](https://hub.docker.com/_/buildpack-deps)
               - base [*Debian:bookworm*](https://hub.docker.com/_/debian)
2. **labsim-devcontainer-gcc-bookworm**
   - from *labsim-base-gcc-bookworm*
3. **labsim-base-llvm-bullseye**
   - from [*buildpack-deps:bullseye-scm*](https://hub.docker.com/_/buildpack-deps)
      - from [*buildpack-deps:bullseye-curl*](https://hub.docker.com/_/buildpack-deps)
         - base [*Debian:bullseye*](https://hub.docker.com/_/debian)
4. **labsim-devcontainer-llvm-bullseye**
   - from *labsim-base-llvm-bullseye*
