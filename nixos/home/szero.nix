{ pkgs-unstable, jadolg-szero-src, ... }:
let
  rootless-personio = pkgs-unstable.buildGoModule {
    pname = "szero";
    version = jadolg-szero-src.rev;
    src = jadolg-szero-src;
    vendorHash = "sha256-IHFE5d4jSGttkBg+By8sCXlaLJo2OqPf8pfxYjAJHBk=";
  };
in
{
  home.packages = [
    rootless-personio
  ];
}

