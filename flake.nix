{
  description = "My NixOS flake";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    nixpkgs-main.url = "nixpkgs/master";
    nixos-hardware.url = "nixos-hardware/master";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, nixpkgs-main, nixos-hardware, home-manager, ... }:
  let
    system = "x86_64-linux";
    lib = nixpkgs.lib;
    pkgs = nixpkgs.legacyPackages.${system};
    pkgs-main = nixpkgs-main.legacyPackages.${system};
    username = "kallefagerberg";
    name = "Kalle";
  in {
    nixosConfigurations = {
      ri-t-0790 = lib.nixosSystem {
        inherit system;
        modules = [
          ./nixos/configuration.nix
          #./nixos/hyprland.nix
          ./nixos/kde.nix
          nixos-hardware.nixosModules.lenovo-thinkpad-t14
        ];
        specialArgs = {
          inherit username;
          inherit name;
        };
      };
    };
    homeConfigurations = {
      kallefagerberg = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          ./nixos/home.nix
          #./nixos/hyprland-home.nix
        ];
        extraSpecialArgs = {
          inherit username;
          inherit name;
          inherit pkgs-main;
        };
      };
    };
  };
}
