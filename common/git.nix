{ config, pkgs, ... }:

{
  programs.git = {
    enable = true;
    lfs.enable = true;

    settings = {
      user = {
        name = "Amelia Keibler";
        email = "akeibler@sonatype.com";
      };

      init = {
        defaultBranch = "main";
      };
    };

    signing = {
      format = "openpgp";
    };
  };

  home.packages = with pkgs; [
    gh
  ];
}
