{ pkgs, applejag-dinkur-src, applejag-dinkur-statusline-src, ... }:
let
  dinkur = pkgs.buildGoModule {
    pname = "dinkur";
    version = applejag-dinkur-src.rev;
    src = applejag-dinkur-src;
    vendorHash = "sha256-Sa2+Nn9U3nyZFamJ9jxa90t9qSdZTruPLu+6fuQ9Lik=";
    tags = [
      "fts5"
    ];
    subPackages = [
      "."
    ];
  };
  dinkur-statusline = pkgs.buildGoModule {
    pname = "dinkur-statusline";
    version = applejag-dinkur-statusline-src.rev;
    src = applejag-dinkur-statusline-src;
    vendorHash = "sha256-OQBV51bTr+xTOvuen4kTk7Ft+zvE7OkaQ6r3lu/SZsg=";
  };
in
{
  systemd.user.services."dinkur" = {
    Unit.Description = "Dinkur daemon";
    Install.WantedBy = ["default.target"];
    Service = {
      Type = "simple";
      Restart = "always";
      RestartSec = 1;
      ExecStart = "${dinkur}/bin/dinkur daemon -v";
    };
  };

  home.packages = [
    dinkur
    dinkur-statusline
  ];
}
