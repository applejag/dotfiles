{ pkgs-unstable, jadolg-szero-src, ... }:
let
  rootless-personio = pkgs-unstable.buildGoModule {
    pname = "szero";
    version = jadolg-szero-src.rev;
    src = jadolg-szero-src;
    vendorHash = "sha256-q58j5DV/him4vhoXYj0MToSVPqE0zThAyQ8XFYJEHH0=";
  };
in
{
  home.packages = [
    rootless-personio
  ];
}

