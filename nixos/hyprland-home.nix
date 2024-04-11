{ config, pkgs, pkgs-main, lib, username, walker, ... }:

{
  imports = [walker.homeManagerModules.walker];


  # Hint electron apps to use Wayland
  home.sessionVariables.NIXOS_OZONE_WL = "1";

  wayland.windowManager.hyprland = {
    enable = true;
    extraConfig = builtins.readFile ../hypr/hyprland.conf;
    systemd.enable = true;
  };

  home.file."hyprpaper.conf" = {
    source = ../hypr/hyprpaper.conf;
    target = ".config/hypr/hyprpaper.conf";
  };

  home.file."hypridle.conf" = {
    source = ../hypr/hypridle.conf;
    target = ".config/hypr/hypridle.conf";
  };

  home.file."hyprlock.conf" = {
    source = ../hypr/hyprlock.conf;
    target = ".config/hypr/hyprlock.conf";
  };

  programs.waybar = {
    enable = true;
    settings = import ../waybar/config.nix;
    style = ../waybar/style.css;
    package = pkgs-main.waybar;
  };

  # wayland app launcher
  programs.walker = {
    enable = true;
    runAsService = true;

    # All options from the config.json can be used here.
    config = {
      placeholder = "Example";
      fullscreen = true;
      list = {
        height = 200;
      };
      modules = [
        {
          name = "websearch";
          prefix = "?";
        }
        {
          name = "switcher";
          prefix = "/";
        }
      ];
    };

    # If this is not set the default styling is used.
    style = ''
      * {
        color: #dcd7ba;
      }
    '';
  };
}
