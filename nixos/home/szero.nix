{ pkgs-unstable, jadolg-szero-src, ... }:
let
  rootless-personio = pkgs-unstable.buildGoModule {
    pname = "szero";
    version = jadolg-szero-src.rev;
    src = jadolg-szero-src;
    vendorHash = "sha256-OvdE9hkrCZ506FmjsbMgcOZHFtwX6ZBISjB+c3YebKc=";
  };
in
{
  home.packages = [
    rootless-personio
  ];
}

