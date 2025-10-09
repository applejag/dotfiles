{ pkgs-unstable, jadolg-szero-src, ... }:
let
  rootless-personio = pkgs-unstable.buildGoModule {
    pname = "szero";
    version = jadolg-szero-src.rev;
    src = jadolg-szero-src;
    vendorHash = "sha256-pNca4O0A05ngXqaGn2XNNuiHUgCzbN6yQqQsKS7N4BM=";
  };
in
{
  home.packages = [
    rootless-personio
  ];
}

