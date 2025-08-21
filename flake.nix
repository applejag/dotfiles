{
  description = "My NixOS flake";

  nixConfig = {
    extra-trusted-substituters = [
      "https://cosmic.cachix.org/" # https://github.com/lilyinstarlight/nixos-cosmic
      "https://cache.flox.dev/" # https://flox.dev/docs/install-flox/
    ];
    extra-trusted-public-keys = [
      "cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE="
      "flox-cache-public-1:7F4OyH7ZCnFhcze3fJdfyXYLQw/aV7GEed86nQ7IsOs="
    ];
  };

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
    nixpkgs-master.url = "nixpkgs/master";
    nixos-hardware.url = "nixos-hardware/master";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flake-programs-sqlite = {
      url = "github:wamserma/flake-programs-sqlite";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
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

    jadolg-szero-src = {
      url = "github:jadolg/szero";
      flake = false;
    };

    helm-values-schema-json = {
      url = ./flakes/helm-values-schema-json;
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
  };

  outputs = {
    nixpkgs,
    nixpkgs-unstable,
    nixpkgs-master,
    flake-programs-sqlite,
    nixos-hardware,
    home-manager,
    zen-browser,
    applejag-dinkur-src,
    applejag-dinkur-statusline-src,
    applejag-showksec-src,
    applejag-rootless-personio-src,
    jadolg-szero-src,
    helm-values-schema-json,
    #nixos-cosmic,
    ... }:
  let
    system = "x86_64-linux";
    lib = nixpkgs.lib;
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
      ri-t-1010 = lib.nixosSystem {
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
                (zen-browser.packages.${system}.default.override {
                  nativeMessagingHosts = [pkgs-unstable.firefoxpwa];
                })
              ];
            };

            environment.etc = {
              "1password/custom_allowed_browsers" = {
                text = ''
                  .zen-wrapped
                  zen-beta
                  zen
                '';
                mode = "0755";
              };
            };

            programs.command-not-found.enable = true;
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
        ];
        specialArgs = {
          inherit username;
          inherit name;
          inherit pkgs-unstable;
          inherit pkgs-master;
          helm-values-schema-json = helm-values-schema-json.packages.${system}.default;
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
          ./nixos/home/szero.nix
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
          inherit jadolg-szero-src;
        };
      };
    };
  };
}
