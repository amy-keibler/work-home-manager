{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    gnupg
    mongosh
  ];
}
