{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
      nodejs_18
      yarn
  ];
}
