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
