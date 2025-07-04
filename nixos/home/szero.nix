{ pkgs-unstable, jadolg-szero-src, ... }:
let
  rootless-personio = pkgs-unstable.buildGoModule {
    pname = "szero";
    version = jadolg-szero-src.rev;
    src = jadolg-szero-src;
    vendorHash = "sha256-iirhMgfHfvz8/y2XyQ0Q0PCJltkyZMOgLOXvTgWIMWI=";
  };
in
{
  home.packages = [
    rootless-personio
  ];
}

