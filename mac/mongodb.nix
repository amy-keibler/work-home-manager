{ config, pkgs, ... }:

{
  home.file = {
    ".config/mongodb/mongod.conf".source = ../dotfiles/mongod/mongod.conf;
    "Library/LaunchAgents/mongod.plist".source = ../dotfiles/launchd/mongod.xml;
  };
}
