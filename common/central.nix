{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    gnupg
    mongodb
    mongosh
    opensearch
  ];
}
