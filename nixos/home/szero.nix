{ pkgs, jadolg-szero-src, ... }:
let
  rootless-personio = pkgs.buildGoModule {
    pname = "szero";
    version = jadolg-szero-src.rev;
    src = jadolg-szero-src;
    vendorHash = "sha256-abhLrb7nvLi0OW0VhB95XDjQ9rAc5xynNps34W++9jg=";
  };
in
{
  home.packages = [
    rootless-personio
  ];
}

