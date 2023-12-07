# Amy's Work Home Manager Configuration

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
1. Activate the LaunchD configuration
   `launchctl load ~/Library/LaunchAgents/mongod.plist`
1. [Set up the root user][mongodb-auth]

##### Docker

1. [Install Podman Desktop][podman-desktop]
1. [Set up Docker Emulation][docker-emulation]

<!-- References  -->

[mongodb-auth]: https://www.mongodb.com/docs/v4.4/tutorial/enable-authentication/
[podman-desktop]: https://podman-desktop.io/docs/installation/macos-install
[docker-emulation]: https://podman-desktop.io/docs/migrating-from-docker/emulating-docker-cli-with-podman
