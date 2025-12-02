{
  description = "Home Manager configuration of amy";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, flake-utils, home-manager, ... }:
    let
      linuxPkgs = import nixpkgs rec {
        system = "x86_64-linux";
        config.allowUnfree = true;
      };
      macPkgs = import nixpkgs rec {
        system = "aarch64-darwin";
        config.allowUnfree = true;
      };
    in
    {
      packages."x86_64-linux" = {
        homeConfigurations."amy" = home-manager.lib.homeManagerConfiguration {
          pkgs = linuxPkgs;
          modules = [ ./home_linux.nix ];
        };
      };
      packages."aarch64-darwin" = {
        homeConfigurations."amy" = home-manager.lib.homeManagerConfiguration {
          pkgs = macPkgs;
          modules = [ ./home_mac.nix ];
        };
      };
    };
}
