{
  description = "Flake for sbt";
 
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
  };
 
  outputs = { self, nixpkgs }:
    let
      supportedSystems = [ "x86_64-linux" "x86_64-darwin" "aarch64-linux" "aarch64-darwin" ];
      forAllSystems = nixpkgs.lib.genAttrs supportedSystems;
    in
    {
      packages = forAllSystems (system:
        let
          pkgs = import nixpkgs { inherit system; };
 
          sbt = pkgs.sbt.overrideAttrs (prevAttrs: {
            postFixup = "";
          });
        in
        {
          default = sbt;
        }
      );
    };
}
