{
  description = "My NixOS flake";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    nixos-hardware.url = "nixos-hardware/master";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    #cue-src.url = "github:cue-lang/cue/v0.9.0-alpha.2";
    cue-src.url = "github:cue-lang/cue/master";
    cue-src.flake = false;
  };

  outputs = {
    self,
    nixpkgs,
    nixos-hardware,
    home-manager,
    cue-src,
    ... }:
  let
    system = "x86_64-linux";
    lib = nixpkgs.lib;
    pkgs = nixpkgs.legacyPackages.${system};
    username = "kallefagerberg";
    name = "Kalle";
  in {
    nixosConfigurations = {
      ri-t-0790 = lib.nixosSystem {
        inherit system;
        modules = [
          ./nixos/configuration.nix
          ./nixos/hyprland.nix
          #./nixos/kde.nix
          nixos-hardware.nixosModules.lenovo-thinkpad-t14

          ({ pkgs, ... }: {
            nixpkgs.overlays = [
              (self: super: {
                cue = super.cue.override {
                  buildGoModule = args: pkgs.buildGoModule ( args // rec {
                    version = "v0.9.0-alpha.2+master";
                    src = cue-src;
                    vendorHash = "sha256-fC6T4d+XsSFnKrpatfSM/hMCx3YSEKMFDg2jEMqG2ug=";
                    ldflags = [ "-s" "-w" "-X cuelang.org/go/cmd/cue/cmd.version=${version}" ];
                  });
                };
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
