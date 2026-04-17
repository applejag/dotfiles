{ pkgs-unstable, jadolg-szero-src, ... }:
let
  szero = pkgs-unstable.buildGoLatestModule {
    pname = "szero";
    version = jadolg-szero-src.rev;
    src = jadolg-szero-src;
    vendorHash = "sha256-bZIE+FjzzZCPnQjcgVmYNFxTUT7+Zni7FH+g4bOQkcI=";
  };
in
{
  home.packages = [
    szero
  ];
}

