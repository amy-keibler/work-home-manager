{ config, pkgs, ... }:

{
  imports = [
    ./common/aws.nix
    ./common/cli.nix
    ./common/git.nix
    ./common/java.nix
  ];

  home.username = "amy";
  home.homeDirectory = "/Users/amy";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.05"; # Please read the comment before changing.

  programs.zsh = {
    enable = true;
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
