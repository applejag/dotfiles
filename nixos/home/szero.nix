{ pkgs-unstable, jadolg-szero-src, ... }:
let
  rootless-personio = pkgs-unstable.buildGoModule {
    pname = "szero";
    version = jadolg-szero-src.rev;
    src = jadolg-szero-src;
    vendorHash = "sha256-V3n3DntDrWG5q8WqM/HzB/ACfQFT6/GSfhx5eKXKAjE=";
  };
in
{
  home.packages = [
    rootless-personio
  ];
}

