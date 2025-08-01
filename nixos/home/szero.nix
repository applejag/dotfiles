{ pkgs-unstable, jadolg-szero-src, ... }:
let
  rootless-personio = pkgs-unstable.buildGoModule {
    pname = "szero";
    version = jadolg-szero-src.rev;
    src = jadolg-szero-src;
    vendorHash = "sha256-RKr59/XXWxMhL578jJ8pboriQdRutX+9mVBYAYsWllg=";
  };
in
{
  home.packages = [
    rootless-personio
  ];
}

