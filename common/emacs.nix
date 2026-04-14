{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    emacs

    # Doom Emacs
    aspell
    aspellDicts.en
    coreutils-prefixed
    fd
    fontconfig
    gnugrep
    mdl
    nerd-fonts.fira-mono
    nerd-fonts.fira-code
    nerd-fonts.symbols-only
    pandoc
    ripgrep
    shellcheck
    # symbola # commented out due to failing

    # formatting and other tools
    cargo
    rustc
    rustfmt
  ];

  home.file = {
    ".config/doom/" = {
      source = ../dotfiles/doom;
      recursive = true;
    };
  };

  fonts.fontconfig.enable = true;

  home.sessionVariables.FONTCONFIG_FILE = "${pkgs.fontconfig.out}/etc/fonts/fonts.conf";
}
