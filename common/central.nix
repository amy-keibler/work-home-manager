{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    gnupg
    mongodb
    opensearch
  ];
}
