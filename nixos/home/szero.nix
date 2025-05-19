{ pkgs-unstable, jadolg-szero-src, ... }:
let
  rootless-personio = pkgs-unstable.buildGoModule {
    pname = "szero";
    version = jadolg-szero-src.rev;
    src = jadolg-szero-src;
    vendorHash = "sha256-Z8ZOPltyInMH2AVWOTPvzRY/WQFXRQMScykJlGRokr8=";
  };
in
{
  home.packages = [
    rootless-personio
  ];
}

