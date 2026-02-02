{ pkgs-unstable, jadolg-next-meeting-src, ... }:
let
  next-meeting = pkgs-unstable.buildGo126Module {
    pname = "next-meeting";
    version = jadolg-next-meeting-src.rev;
    src = jadolg-next-meeting-src;
    vendorHash = "sha256-z09NryetWOJs1gGlyVlfh9Skrj71f4CpgXn0HVhOZoY=";
  };
in
{
  home.packages = [
    next-meeting
  ];
}
