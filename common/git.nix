{ config, pkgs, ... }:

{
  programs.git = {
    enable = true;
    lfs.enable = true;

    userName = "Amelia Keibler";
    userEmail = "akeibler@sonatype.com";

    extraConfig = {
      init = {
        defaultBranch = "main";
      };
    };
  };

  home.packages = with pkgs; [
    gh
  ];
}
