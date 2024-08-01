{
  description = "My NixOS flake";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
    nixos-hardware.url = "nixos-hardware/master";

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    zig-src = {
      url = "github:ziglang/zig/0.13.0";
      flake = false;
    };

    nixos-cosmic = {
      url = "github:lilyinstarlight/nixos-cosmic";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    applejag-dinkur-src = {
      url = "github:applejag/dinkur";
      flake = false;
    };

    applejag-dinkur-statusline-src = {
      url = "github:applejag/dinkur-statusline";
      flake = false;
    };
  };

  outputs = {
    nixpkgs,
    nixpkgs-unstable,
    nixos-hardware,
    home-manager,
    zig-src,
    applejag-dinkur-src,
    applejag-dinkur-statusline-src,
    #nixos-cosmic,
    ... }:
  let
    system = "x86_64-linux";
    lib = nixpkgs.lib;
    pkgs = nixpkgs.legacyPackages.${system};
    pkgs-unstable = nixpkgs-unstable.legacyPackages.${system};
    username = "kallefagerberg";
    name = "Kalle";
  in {
    nixosConfigurations = {
      ri-t-0788 = lib.nixosSystem {
        inherit system;
        modules = [
          # https://github.com/lilyinstarlight/nixos-cosmic
          {
            nix.settings = {
              substituters = [ "https://cosmic.cachix.org/" ];
              trusted-public-keys = [ "cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE=" ];
            };
          }
          #nixos-cosmic.nixosModules.default

          ./nixos/ri-t-0788/configuration.nix
          ./nixos/configuration.nix
          #./nixos/hyprland.nix
          #./nixos/cosmic.nix
          ./nixos/kde.nix
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
          inherit pkgs-unstable;
        };
      };

      ri-t-1010 = lib.nixosSystem {
        inherit system;
        modules = [
          # https://github.com/lilyinstarlight/nixos-cosmic
          {
            nix.settings = {
              substituters = [ "https://cosmic.cachix.org/" ];
              trusted-public-keys = [ "cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE=" ];
            };
          }
          #nixos-cosmic.nixosModules.default

          ./nixos/ri-t-1010/configuration.nix
          ./nixos/configuration.nix
          #./nixos/hyprland.nix
          #./nixos/cosmic.nix
          ./nixos/kde.nix
          nixos-hardware.nixosModules.lenovo-thinkpad-z13-gen2

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
          inherit pkgs-unstable;
        };
      };
    };
    homeConfigurations = {
      kallefagerberg = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          ./nixos/home/home.nix
          #./nixos/home/hyprland.nix
          ./nixos/home/dinkur.nix
        ];
        extraSpecialArgs = {
          inherit username;
          inherit name;
          inherit pkgs-unstable;
          inherit applejag-dinkur-src;
          inherit applejag-dinkur-statusline-src;
        };
      };
    };
  };
}
