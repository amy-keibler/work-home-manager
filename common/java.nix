{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    jdk17
    maven
  ];

  programs.zsh.sessionVariables = {
    JAVA_HOME = "${pkgs.jdk17}";
  };
}
