{
  description = "My NixOS flake";

  nixConfig = {
    extra-substituters = [
      "https://cosmic.cachix.org/" # https://github.com/lilyinstarlight/nixos-cosmic
      "https://cache.flox.dev"     # https://flox.dev
    ];
    extra-trusted-public-keys = [
      "cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE="
      "flox-cache-public-1:7F4OyH7ZCnFhcze3fJdfyXYLQw/aV7GEed86nQ7IsOs="
    ];
  };

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
    nixpkgs-master.url = "nixpkgs/master";
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

    applejag-rootless-personio-src = {
      url = "github:applejag/rootless-personio";
      flake = false;
    };

    flox.url = "github:flox/flox/v1.3.0";
  };

  outputs = {
    nixpkgs,
    nixpkgs-unstable,
    nixpkgs-master,
    flake-programs-sqlite,
    nixos-hardware,
    home-manager,
    zig-src,
    applejag-dinkur-src,
    applejag-dinkur-statusline-src,
    applejag-showksec-src,
    applejag-rootless-personio-src,
    #nixos-cosmic,
    flox,
    ... }:
  let
    system = "x86_64-linux";
    lib = nixpkgs.lib;
    pkgs = nixpkgs.legacyPackages.${system};
    pkgs-unstable = nixpkgs-unstable.legacyPackages.${system};
    pkgs-master = nixpkgs-master.legacyPackages.${system};
    username = "kallefagerberg";
    name = "Kalle";
  in {
    nixosConfigurations = {
      ri-t-1010 = lib.nixosSystem {
        inherit system;
        modules = [
          {
            nix.settings = {
              experimental-features = [ "nix-command" "flakes" ];
              substituters = [
                "https://cosmic.cachix.org/" # https://github.com/lilyinstarlight/nixos-cosmic
                "https://cache.flox.dev"     # https://flox.dev
              ];
              trusted-public-keys = [
                "cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE="
                "flox-cache-public-1:7F4OyH7ZCnFhcze3fJdfyXYLQw/aV7GEed86nQ7IsOs="
              ];
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

          {
            users.users.${username}.packages = [
              flox.packages.${system}.default
            ];
          }

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
          inherit pkgs-master;
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
          ./nixos/home/rootless-personio.nix
        ];
        extraSpecialArgs = {
          inherit username;
          inherit name;
          inherit pkgs-unstable;
          inherit pkgs-master;
          inherit applejag-dinkur-src;
          inherit applejag-dinkur-statusline-src;
          inherit applejag-showksec-src;
          inherit applejag-rootless-personio-src;
        };
      };
    };
  };
}
