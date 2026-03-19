{ pkgs-unstable, jadolg-next-meeting-src, ... }:
let
  next-meeting = pkgs-unstable.buildGo126Module {
    pname = "next-meeting";
    version = jadolg-next-meeting-src.rev;
    src = jadolg-next-meeting-src;
    vendorHash = "sha256-LLwKShUyavbFeZEzY6wwEZ+HPQ2ewHzlR0U00oSpEhU=";
  };
in
{
  home.packages = [
    next-meeting
  ];
}
