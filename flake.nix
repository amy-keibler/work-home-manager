{
  description = "Home Manager configuration of amy";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, flake-utils, home-manager, ... }:
    let
      linuxPkgs = nixpkgs.legacyPackages."x86_64-linux";
      macPkgs = nixpkgs.legacyPackages."aarch64-darwin";
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
          pkgs = linuxPkgs;
          modules = [ ./home_mac.nix ];
        };
      };
    };
}
