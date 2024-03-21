{
  description = "My NixOS flake";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    nixos-hardware.url = "nixos-hardware/master";
  };

  outputs = { self, nixpkgs, nixos-hardware, ... }:
  let
    lib = nixpkgs.lib;
  in {
    nixosConfigurations = {
      ri-t-0790 = lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./nixos/configuration.nix
          nixos-hardware.nixosModules.lenovo-thinkpad-t14
        ];
      };
    };
  };
}
