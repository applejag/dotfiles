{ pkgs, applejag-rootless-personio-src, ... }:
let
  rootless-personio = pkgs.buildGoModule {
    pname = "rootless-personio";
    version = applejag-rootless-personio-src.rev;
    src = applejag-rootless-personio-src;
    vendorHash = "sha256-KuQY3t6p526fLje4qq/ntZyLI8MnGzty9uTZszNwMmU=";
  };
in
{
  home.packages = [
    rootless-personio
  ];
}

