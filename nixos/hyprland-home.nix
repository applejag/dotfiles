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
      #placeholder = "Example";
      fullscreen = false;
      list = {
        height = 200;
      };
      enable_typeahead = true;
      hyprland = {
        context_aware_history = true;
      };
      terminal = "${pkgs.alacritty}/bin/alacritty";
      modules = [
        {
          name = "applications";
        }
        {
          name = "finder";
          switcher_exclusive = true;
        }
        {
          name = "hyprland";
          prefix = "-";
        }
        {
          name = "switcher";
          prefix = "/";
        }
      ];
    };
  };

  nix = {
    package = pkgs.nix;
    settings = {
      substituters = [
        "https://cache.nixos.org/"
        "https://walker.cachix.org"
      ];
      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "walker.cachix.org-1:fG8q+uAaMqhsMxWjwvk0IMb4mFPFLqHjuvfwQxE4oJM="
      ];
    };
  };
}
