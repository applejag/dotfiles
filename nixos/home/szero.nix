{ pkgs, jadolg-szero-src, ... }:
let
  rootless-personio = pkgs.buildGoModule {
    pname = "szero";
    version = jadolg-szero-src.rev;
    src = jadolg-szero-src;
    vendorHash = "sha256-Jm88Lr06bEqV8r1puLIcfOD4TymfXhuymynaXXqdL2E=";
  };
in
{
  home.packages = [
    rootless-personio
  ];
}

