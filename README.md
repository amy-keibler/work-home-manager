# Amy's Work Home Manager Configuration

## Prerequisites

This setup was reverse-engineered from an existing laptop. In order to set up a
new laptop, install the following software (that is not currently available via
`nixpkgs`):

- [JetBrains Toolbox](https://www.jetbrains.com/toolbox-app/)
- [`nvm` (Node Version Manager)](https://github.com/nvm-sh/nvm)
- [`sdk` (SdkMan)](https://sdkman.io/)

## Usage

On first setup, run `nix run home-manager/master -- init --switch`. After that,
run `home-manager switch`.

## Environments

### Linux

Reverse engineered based on the existing laptop configuration.

### Mac

Built using the Linux configuration as a foundation.

- Uses `zsh` instead of `bash`
- Uses `doom` Emacs instead of `spacemacs`

#### Manual Setup Steps

##### MongoDB

1. `mkdir -p ~/.local/state/mongodb/ && mkdir -p ~/.local/share/mongodb/db/`
1. Activate the LaunchD configuration `launchctl load ~/Library/LaunchAgents/mongod.plist`
1. [Set up the root user](https://www.mongodb.com/docs/v4.4/tutorial/enable-authentication/)

##### Docker

1. [Install Podman Desktop](https://podman-desktop.io/docs/installation/macos-install)
1. [Set up Docker Emulation](https://podman-desktop.io/docs/migrating-from-docker/emulating-docker-cli-with-podman)
