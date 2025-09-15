{ pkgs-unstable, jadolg-szero-src, ... }:
let
  rootless-personio = pkgs-unstable.buildGoModule {
    pname = "szero";
    version = jadolg-szero-src.rev;
    src = jadolg-szero-src;
    vendorHash = "sha256-C/oNoWgCoLtH+7w2llbvw1MywVXFveADPUcTKqXCxGI=";
  };
in
{
  home.packages = [
    rootless-personio
  ];
}

