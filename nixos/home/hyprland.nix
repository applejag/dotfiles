{ config, pkgs, lib, username, ... }:

{
  # Hint electron apps to use Wayland
  home.sessionVariables.NIXOS_OZONE_WL = "1";

  wayland.windowManager.hyprland = {
    enable = true;
    extraConfig = builtins.readFile ../hypr/hyprland.conf;
    systemd.enable = true;
  };

  home.file."hyprpaper.conf" = {
    source = ../../hypr/hyprpaper.conf;
    target = ".config/hypr/hyprpaper.conf";
  };

  home.file."hypridle.conf" = {
    source = ../../hypr/hypridle.conf;
    target = ".config/hypr/hypridle.conf";
  };

  home.file."hyprlock.conf" = {
    source = ../../hypr/hyprlock.conf;
    target = ".config/hypr/hyprlock.conf";
  };

  programs.waybar = {
    enable = true;
    settings = import ../../waybar/config.nix;
    style = ../../waybar/style.css;
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
