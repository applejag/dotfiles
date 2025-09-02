{ pkgs-unstable, jadolg-szero-src, ... }:
let
  rootless-personio = pkgs-unstable.buildGoModule {
    pname = "szero";
    version = jadolg-szero-src.rev;
    src = jadolg-szero-src;
    vendorHash = "sha256-sH8D4T5FRpwVqe03bd+oTDETy/f0ALMR/sLsMjCHpNk=";
  };
in
{
  home.packages = [
    rootless-personio
  ];
}

