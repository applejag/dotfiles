{ pkgs-unstable, jadolg-szero-src, ... }:
let
  szero = pkgs-unstable.buildGoModule {
    pname = "szero";
    version = jadolg-szero-src.rev;
    src = jadolg-szero-src;
    vendorHash = "sha256-0yUn/TKXJ/3ylfauqynFTGTrgkbD5fRYBhmzgPft+oY=";
  };
in
{
  home.packages = [
    szero
  ];
}

