{
  description = "My NixOS flake";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    nixos-hardware.url = "nixos-hardware/master";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    zig-src.url = "github:ziglang/zig/0.13.0";
    zig-src.flake = false;
  };

  outputs = {
    nixpkgs,
    nixos-hardware,
    home-manager,
    zig-src,
    ... }:
  let
    system = "x86_64-linux";
    lib = nixpkgs.lib;
    pkgs = nixpkgs.legacyPackages.${system};
    username = "kallefagerberg";
    name = "Kalle";
  in {
    nixosConfigurations = {
      ri-t-0788 = lib.nixosSystem {
        inherit system;
        modules = [
          ./nixos/configuration.nix
          ./nixos/hyprland.nix
          #./nixos/kde.nix
          nixos-hardware.nixosModules.lenovo-thinkpad-t14

          ({ ... }: {
            nixpkgs.overlays = [
              (self: super: {
                zig = super.zig.overrideAttrs (final: prev: {
                  src = zig-src;
                });
              })
            ];
          })
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
          ./nixos/hyprland-home.nix
        ];
        extraSpecialArgs = {
          inherit username;
          inherit name;
        };
      };
    };
  };
}
