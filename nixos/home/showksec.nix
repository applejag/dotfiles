{ pkgs, applejag-showksec-src, ... }:
let
  showksec = pkgs.buildGoModule {
    pname = "dinkur";
    version = applejag-showksec-src.rev;
    src = applejag-showksec-src;
    vendorHash = "sha256-5RQhQ8oljwUcJAOWXykd8zEiH3vLJ/pdvsHJkPJhCug=";
  };
in
{
  home.packages = [
    showksec
  ];
}
