{
  description = "Flake for Scala";
 
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
          version = "3.3.3";
          ncurses = pkgs.ncurses;
 
          scalaFor = {
            x86_64-linux = {
              url = "https://github.com/scala/scala3/releases/download/${version}/scala3-${version}.tar.gz";
              hash = "sha256-61lAETEvqkEqr5pbDltFkh+Qvp+EnCDilXN9X67NFNE=";
            };
          };
          scala = pkgs.stdenv.mkDerivation {
            pname = "scala";
            version = version;
            src = pkgs.fetchurl scalaFor.${system};
            preFixup = ''
              bin_files=$(find $out/bin -type f ! -name "*common*" ! -name "scala-cli.jar")
              for f in $bin_files ; do
                wrapProgram $f --prefix PATH : '${ncurses.dev}/bin'
              done
            '';
          };
        in
        {
          default = scala;
        }
      );
    };
}
