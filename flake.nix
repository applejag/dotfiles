{
  description = "My NixOS flake";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
    nixpkgs-master.url = "nixpkgs/master";
    nixos-hardware.url = "nixos-hardware/master";

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flake-programs-sqlite = {
      url = "github:wamserma/flake-programs-sqlite";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zig-src = {
      url = "github:ziglang/zig/0.13.0";
      flake = false;
    };

    zen-browser = {
      url = "github:ch4og/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    nixos-cosmic = {
      url = "github:lilyinstarlight/nixos-cosmic";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    ghostty = {
      url = "github:ghostty-org/ghostty/v1.0.1";
      inputs.nixpkgs-unstable.follows = "nixpkgs-unstable";
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
  };

  outputs = {
    nixpkgs,
    nixpkgs-unstable,
    nixpkgs-master,
    flake-programs-sqlite,
    nixos-hardware,
    home-manager,
    zig-src,
    zen-browser,
    applejag-dinkur-src,
    applejag-dinkur-statusline-src,
    applejag-showksec-src,
    applejag-rootless-personio-src,
    #nixos-cosmic,
    ghostty,
    ... }:
  let
    system = "x86_64-linux";
    #lib = nixpkgs.lib;
    lib-unstable = nixpkgs-unstable.lib;
    pkgs = nixpkgs.legacyPackages.${system};
    pkgs-unstable = nixpkgs-unstable.legacyPackages.${system};
    #pkgs-unstable = nixpkgs-unstable.legacyPackages.${system}.extend (final: prev: {
    #  go = prev.go_1_23;
    #  buildGoModule = prev.buildGo123Module;
    #});
    pkgs-master = nixpkgs-master.legacyPackages.${system};
    username = "kallefagerberg";
    name = "Kalle";
  in {
    nixosConfigurations = {
      #ri-t-1010 = lib.nixosSystem {
      ri-t-1010 = lib-unstable.nixosSystem {
        inherit system;
        modules = [
          {
            nix.settings = {
              experimental-features = [ "nix-command" "flakes" ];
              substituters = [
                "https://cosmic.cachix.org/" # https://github.com/lilyinstarlight/nixos-cosmic
              ];
              trusted-public-keys = [
                "cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE="
              ];
            };

            users.users.${username} = {
              packages = [
                zen-browser.packages."${system}".default
                ghostty.packages."${system}".default
              ];
            };

            environment.etc = {
              "1password/custom_allowed_browsers" = {
                text = ''
                  .zen-wrapped
                '';
                mode = "0755";
              };
            };
          }

          flake-programs-sqlite.nixosModules.programs-sqlite

          ./nixos/ri-t-1010/configuration.nix
          ./nixos/configuration.nix
          #./nixos/hyprland.nix
          #./nixos/kde.nix
          ./nixos/niri.nix

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
          ./nixos/home/niri.nix

          ./nixos/home/dinkur.nix
          ./nixos/home/showksec.nix
          ./nixos/home/rootless-personio.nix
          ./nixos/home/pyenv.nix
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
