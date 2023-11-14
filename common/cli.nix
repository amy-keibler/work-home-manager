{ config, pkgs, ... }:

{
  programs.direnv.enable = true;

  programs.starship = {
    enable = true;
    settings = {
      kubernetes = {
        disabled = true;
      };
    };
  };

  programs.vim = {
    enable = true;
    defaultEditor = true;
  };

  # man pages were causing issues with locale
  programs.man.enable = false;
  home.extraOutputsToInstall = [ "man" ];

  home.language = {
    base = "en_US.utf-8";
  };

  home.sessionVariables = { };
}