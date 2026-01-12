{ pkgs-unstable, jadolg-szero-src, ... }:
let
  szero = pkgs-unstable.buildGoModule {
    pname = "szero";
    version = jadolg-szero-src.rev;
    src = jadolg-szero-src;
    vendorHash = "sha256-dncQzLSblPjoTl8X9BK+lhKCn0DNIX7bs1v6Od0hPbU=";
  };
in
{
  home.packages = [
    szero
  ];
}

