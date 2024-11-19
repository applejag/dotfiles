{ config, pkgs, lib, username, ... }:

{
  # Hint electron apps to use Wayland
  home.sessionVariables.NIXOS_OZONE_WL = "1";

  programs.waybar = {
    enable = true;
    settings = import ../../waybar/config.nix;
    style = ../../waybar/style.css;
  };

  home.file.".config/niri/config.kdl" = {
    source = ../../niri/config.kdl;
  };

  nix = {
    package = pkgs.nix;
    settings = {
      substituters = [
        "https://cache.nixos.org/"
      ];
      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      ];
    };
  };
}
