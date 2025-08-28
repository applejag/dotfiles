{ pkgs-unstable, jadolg-szero-src, ... }:
let
  rootless-personio = pkgs-unstable.buildGoModule {
    pname = "szero";
    version = jadolg-szero-src.rev;
    src = jadolg-szero-src;
    vendorHash = "sha256-TkNDNSurIR8Xg8+CQnBtEyBvnFL4RkyiZU6DzjLx198=";
  };
in
{
  home.packages = [
    rootless-personio
  ];
}

