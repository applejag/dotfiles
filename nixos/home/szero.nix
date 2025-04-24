{ pkgs, jadolg-szero-src, ... }:
let
  rootless-personio = pkgs.buildGoModule {
    pname = "szero";
    version = jadolg-szero-src.rev;
    src = jadolg-szero-src;
    vendorHash = "sha256-lSAHEiDoBIS48dymXvi6CO0kIAEIqxIshG6gbQVzQlY=";
  };
in
{
  home.packages = [
    rootless-personio
  ];
}

