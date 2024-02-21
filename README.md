# Amy's Work Home Manager Configuration

## Usage

On first setup, run `nix run home-manager/master -- init --switch`. After that,
run `home-manager switch`.

### Updates to Doom Emacs Configs

If an update to any of the Doom Emacs configurations is made, run `doom sync` to
make sure the changes are applied.

## Environments

### Linux

Reverse engineered based on the existing laptop configuration.

### Mac

Built using the Linux configuration as a foundation.

- Uses `zsh` instead of `bash`
- Uses `doom` Emacs instead of `spacemacs`
