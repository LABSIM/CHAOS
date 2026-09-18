# CHAOS distro description

> *container stack* : [Docker](https://www.docker.com/) = DockerCE/EE + [BuildKit](https://github.com/moby/buildkit)
>
> *fullname* : ***UMBRELLA distros - Debian Linux 13 & GCC 16***
>
> *author* : Nawfel KINANI - DTIS/ICNA

## Stage build targets

1. **umbrella-base-gcc-trixie**
   - from [*gcc:16.2.0-trixie*](https://github.com/docker-library/gcc/blob/5719f2f1af9000a4129748ce85656c7964b76c31/16/Dockerfile)
      - from [*buildpack-deps:trixie*](https://hub.docker.com/_/buildpack-deps)
         - from [*buildpack-deps:trixie-scm*](https://hub.docker.com/_/buildpack-deps)
            - from [*buildpack-deps:trixie-curl*](https://hub.docker.com/_/buildpack-deps)
               - base [*Debian:trixie*](https://hub.docker.com/_/debian)
2. **umbrella-devcontainer-gcc-bookworm**
   - from *umbrella-base-gcc-bookworm*
