{ config, pkgs, ... }:

{
  imports = [
    ./common/aws.nix
    ./common/cli.nix
    ./common/git.nix
    ./common/java.nix
    ./common/javascript.nix
  ];

  home.username = "amy";
  home.homeDirectory = "/home/amy";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.05"; # Please read the comment before changing.

  programs.bash = {
    enable = true;
    enableCompletion = true;

    historySize = 1000;
    historyFileSize = 2000;
    historyControl = [ "ignoredups" "ignorespace" ];

    shellAliases = {
      # likely won't need these once switched over to a Mac
      vpn_start = "openvpn3 session-start --config ~/.openvpn3/sonatype_vpn.ovpn";
      vpn_stop = "openvpn3 session-manage --disconnect --config ~/.openvpn3/sonatype_vpn.ovpn";
      vpn_status = "openvpn3 sessions-list";
      vpn_restart = "vpn_stop && vpn_start";
    };

    bashrcExtra = ''
      # Likely won't need this once switched over to a Mac
      export PATH=/home/amy/.local/bin/:/home/amy/.docker/cli-plugins:$PATH

      export NVM_DIR="$HOME/.nvm"
      [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
      [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

      #THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
      export SDKMAN_DIR="$HOME/.sdkman"
      [[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
    '';

    profileExtra = ''
            # Added by Toolbox App
      export PATH="$PATH:/home/amy/.local/share/JetBrains/Toolbox/scripts"
    '';
  };

  home.file = {
    ".spacemacs".source = dotfiles/.spacemacs;
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
