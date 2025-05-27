{
  description = "Flake for losisin/helm-values-schema-json";
 
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";

    helm-values-schema-json-src = {
      url = "github:applejag/helm-values-schema-json/8729c8091d76dc2c83323ba5cc30aa0e81c4954a";
      flake = false;
    };
  };
 
  outputs = { self, nixpkgs, helm-values-schema-json-src }:
    let
      supportedSystems = [ "x86_64-linux" "x86_64-darwin" "aarch64-linux" "aarch64-darwin" ];
      forAllSystems = nixpkgs.lib.genAttrs supportedSystems;
    in
    {
      packages = forAllSystems (system:
        let
          pkgs = import nixpkgs { inherit system; };
 
          helm-values-schema-json = pkgs.buildGoModule rec {
            name = "helm-values-schema-json";

            src = helm-values-schema-json-src;

            vendorHash = "sha256-bt6wRDlDqPLiy/b0MBPQIgkh/lxZGvlXEt3N/MZiHTI=";

            # NOTE: Remove the install and upgrade hooks.
            postPatch = ''
              sed -i '/^hooks:/,+2 d' plugin.yaml
            '';

            postInstall = ''
              install -dm755 $out/${name}
              mv $out/bin/helm-values-schema-json $out/${name}/schema
              rmdir $out/bin
              install -m644 -Dt $out/${name} plugin.yaml
            '';

            meta = with pkgs.lib; {
              description = "Helm plugin for generating values.schema.json from multiple values files ";
              homepage = "https://github.com/losisin/helm-values-schema-json";
              license = licenses.mit;
            };
          };
        in
        {
          default = helm-values-schema-json;
        }
      );
    };
}
