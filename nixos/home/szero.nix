{ pkgs-unstable, jadolg-szero-src, ... }:
let
  szero = pkgs-unstable.buildGo126Module {
    pname = "szero";
    version = jadolg-szero-src.rev;
    src = jadolg-szero-src;
    vendorHash = "sha256-lf2m6UGxS6ckhAflaWLg8+7V2Cn8HFrLNh0CJEoqf9w=";
  };
in
{
  home.packages = [
    szero
  ];
}

