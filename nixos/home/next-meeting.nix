{ pkgs-unstable, jadolg-next-meeting-src, ... }:
let
  next-meeting = pkgs-unstable.buildGoModule {
    pname = "next-meeting";
    version = jadolg-next-meeting-src.rev;
    src = jadolg-next-meeting-src;
    vendorHash = "sha256-yupag1zLo3IEsWrBPyex8c6NicVuyTdHMroP0TNaLWI=";
  };
in
{
  home.packages = [
    next-meeting
  ];
}
