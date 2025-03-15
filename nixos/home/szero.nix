{ pkgs, jadolg-szero-src, ... }:
let
  rootless-personio = pkgs.buildGoModule {
    pname = "szero";
    version = jadolg-szero-src.rev;
    src = jadolg-szero-src;
    vendorHash = "sha256-TvXJS+X75hvjmRzkA2h+niacoK0IkTQQhaAgmjeg35g=";
  };
in
{
  home.packages = [
    rootless-personio
  ];
}

