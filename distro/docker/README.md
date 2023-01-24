# CHAOS distro description

> *container stack* : [Docker](https://www.docker.com/) = DockerCE/EE + [BuildKit](https://github.com/moby/buildkit)
>
> *fullname* : ***LABSIM distros - Debian Linux & GCC/LLVM***
>
> *author* : Nawfel KINANI - DTIS/ICNA

## Stage build targets

1. **labsim-base-gcc-bullseye**
   - from [*gcc:12.2.0-bullseye*](https://hub.docker.com/layers/library/gcc/12.2.0-bullseye/images/sha256-6c32676b5b8ae90bb5a5d1fa8c0b7696f015fa4645fbb20fac437fdcea5fd33d?context=explore)
      - from [*buildpack-deps:bullseye*](https://hub.docker.com/_/buildpack-deps)
         - from [*buildpack-deps:bullseye-scm*](https://hub.docker.com/_/buildpack-deps)
            - from [*buildpack-deps:bullseye-curl*](https://hub.docker.com/_/buildpack-deps)
               - base [*Debian:bullseye*](https://hub.docker.com/_/debian)
2. **labsim-devcontainer-gcc-bullseye**
   - from *labsim-base-gcc-bullseye*
3. **labsim-base-llvm-bullseye**
   - from [*buildpack-deps:bullseye-scm*](https://hub.docker.com/_/buildpack-deps)
      - from [*buildpack-deps:bullseye-curl*](https://hub.docker.com/_/buildpack-deps)
         - base [*Debian:bullseye*](https://hub.docker.com/_/debian)
4. **labsim-devcontainer-llvm-bullseye**
   - from *labsim-base-llvm-bullseye*
