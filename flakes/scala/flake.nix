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
          ncurses = pkgs.ncurses;
 
          scala = pkgs.scala.overrideAttrs (prevAttrs: {
            propagatedBuildInputs = [
              ncurses.dev
            ];

            preFixup = ''
              bin_files=$(find $out/bin -type f ! -name "*common*" ! -name "scala-cli.jar")
              for f in $bin_files ; do
                wrapProgram $f --set --prefix PATH : '${ncurses.dev}/bin'
              done
            '';
          });
        in
        {
          default = scala;
        }
      );
    };
}
