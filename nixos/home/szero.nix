{ pkgs-unstable, jadolg-szero-src, ... }:
let
  rootless-personio = pkgs-unstable.buildGoModule {
    pname = "szero";
    version = jadolg-szero-src.rev;
    src = jadolg-szero-src;
    vendorHash = "sha256-Qxc39NP0r4kc2PLpUikcBShVwYSk2i8HewFnRbsVoOg=";
  };
in
{
  home.packages = [
    rootless-personio
  ];
}

