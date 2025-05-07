{ pkgs-unstable, jadolg-szero-src, ... }:
let
  rootless-personio = pkgs-unstable.buildGoModule {
    pname = "szero";
    version = jadolg-szero-src.rev;
    src = jadolg-szero-src;
    vendorHash = "sha256-IBQ6nD7UwIF0dyvAkH9sGN8sN6zX9Tok5WUDdRhATnE=";
  };
in
{
  home.packages = [
    rootless-personio
  ];
}

