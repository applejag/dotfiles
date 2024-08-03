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

    flake-programs-sqlite = {
      url = "github:wamserma/flake-programs-sqlite";
      inputs.nixpkgs.follows = "nixpkgs";
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

    applejag-showksec-src = {
      url = "github:applejag/showksec";
      flake = false;
    };
  };

  outputs = {
    nixpkgs,
    nixpkgs-unstable,
    flake-programs-sqlite,
    nixos-hardware,
    home-manager,
    zig-src,
    applejag-dinkur-src,
    applejag-dinkur-statusline-src,
    applejag-showksec-src,
    #nixos-cosmic,
    ... }:
  let
    system = "x86_64-linux";
    lib = nixpkgs.lib;
    lib-unstable = nixpkgs-unstable.lib;
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

          flake-programs-sqlite.nixosModules.programs-sqlite

          ./nixos/ri-t-1010/configuration.nix
          ./nixos/configuration.nix
          #./nixos/hyprland.nix
          ./nixos/kde.nix

          #nixos-cosmic.nixosModules.default
          #./nixos/cosmic.nix

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
          ./nixos/home/showksec.nix
        ];
        extraSpecialArgs = {
          inherit username;
          inherit name;
          inherit pkgs-unstable;
          inherit applejag-dinkur-src;
          inherit applejag-dinkur-statusline-src;
          inherit applejag-showksec-src;
        };
      };
    };
  };
}
