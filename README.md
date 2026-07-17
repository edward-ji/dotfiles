# Dotfiles

My user-specific application configuration.

## Try with Docker

[![Docker Image Version](https://img.shields.io/docker/v/edwardji/dotfiles?style=flat-square&logo=docker&logoColor=E5F2FC&logoSize=auto&label=&labelColor=17191E&color=1D63ED)][dockerhub]
[![amd64 Docker Image Size](https://img.shields.io/docker/image-size/edwardji/dotfiles?arch=amd64&style=flat-square&logo=amd&logoColor=FFFFFF&logoSize=auto&label=&labelColor=080225&color=1D63ED)][dockerhub]
[![arm64 Docker Image Size](https://img.shields.io/docker/image-size/edwardji/dotfiles?arch=arm64&style=flat-square&logo=arm&logoColor=FFFFFF&logoSize=auto&label=&labelColor=080225&color=1D63ED)][dockerhub]

To quickly test the configurations in a Docker environment, you can run the
following command. This will pull the latest Docker image, start an interactive
terminal session that will be removed when you exit.

```
docker run --rm -it edwardji/dotfiles:latest
```

[dockerhub]: https://hub.docker.com/r/edwardji/dotfiles

## Installation

### mise

Dotfiles are managed with [mise](https://mise.jdx.dev/dotfiles.html). Clone
the repository with submodules, trust its configuration, and let mise symlink
everything into place.

```
git clone --recurse-submodules git@github.com:edward-ji/dotfiles.git
cd dotfiles
mise trust
mise dotfiles apply
```

To preview changes without writing anything, or to inspect the current state,
use the following commands.

```
mise dotfiles apply --dry-run
mise dotfiles status
```

> [!WARNING]
>
> The command below will overwrite your existing configurations. Make sure you
> have backups of any important files before proceeding.

mise refuses to replace existing files it does not manage. If you want the
repository's versions to win over your existing configurations, apply with
force:

```
mise dotfiles apply --force
```

### Docker

> [!NOTE]
> On Linux, Docker does not map UID/GID for host volumes. The `TARGET_UID` and
> `TARGET_GID` variables set the container’s user and group to match your host
> system, ensuring proper file permissions when working with mounted host
> volumes.

To seamlessly integrate the dotfiles container with your environment, use the
following command. This matches the container’s user and group with the host’s,
sets the terminal type for proper functionality, and binds the current directory
as the working directory inside the container.

```
docker run -it \
    --env TARGET_UID=$(id -u) \
    --env TARGET_GID=$(id -g) \
    --env TERM=$TERM \
    --volume $(pwd):$(pwd) \
    --workdir $(pwd) \
    edwardji/dotfiles:latest
```
