{ pkgs-unstable, jadolg-next-meeting-src, ... }:
let
  next-meeting = pkgs-unstable.buildGo126Module {
    pname = "next-meeting";
    version = jadolg-next-meeting-src.rev;
    src = jadolg-next-meeting-src;
    vendorHash = "sha256-c2uWNQYIQDdcdthpAbZaYYTQWS1yMKB+5jCUWcdWAME=";
  };
in
{
  home.packages = [
    next-meeting
  ];
}
