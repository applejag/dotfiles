{ pkgs-unstable, jadolg-szero-src, ... }:
let
  szero = pkgs-unstable.buildGo126Module {
    pname = "szero";
    version = jadolg-szero-src.rev;
    src = jadolg-szero-src;
    vendorHash = "sha256-Pmi5brNTd4T1CjESDWh/YW+2kkqI5+NkOZQQfLbCf6Y=";
  };
in
{
  home.packages = [
    szero
  ];
}

