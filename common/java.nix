{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    maven
  ];

  programs.zsh = {
    sessionVariables = rec {
      JAVA_HOME = JAVA_17_HOME;
      JAVA_17_HOME = "${pkgs.jdk17}";
      JAVA_21_HOME = "${pkgs.jdk21}";
    };

    shellAliases = {
      useJdk17 = "export JAVA_HOME=$JAVA_17_HOME";
      useJdk21 = "export JAVA_HOME=$JAVA_21_HOME";
    };
  };
}
