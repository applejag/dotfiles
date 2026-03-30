{ pkgs-unstable, jadolg-szero-src, ... }:
let
  szero = pkgs-unstable.buildGo126Module {
    pname = "szero";
    version = jadolg-szero-src.rev;
    src = jadolg-szero-src;
    vendorHash = "sha256-2VHd7r4xSj8IaVARvEi2Ha9mpJRZeuXztf8w3GPkb7c=";
  };
in
{
  home.packages = [
    szero
  ];
}

