{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    gnupg
    hexyl
    mkcert
    mongosh
  ];
}
