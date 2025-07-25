{ config, pkgs, pkgs-unstable, lib, username, ... }:

{
  # Hint electron apps to use Wayland
  home.sessionVariables.NIXOS_OZONE_WL = "1";

  programs.waybar = {
    enable = true;
    settings = import ../../waybar/config.nix;
    style = ../../waybar/style.css;
    package = pkgs-unstable.waybar;
  };

  home.file.".config/niri/config.kdl" = {
    source = ../../niri/landet-2025.kdl;
  };

  home.file."hyprlock.conf" = {
    source = ../../hypr/hyprlock.conf;
    target = ".config/hypr/hyprlock.conf";
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

  systemd.user = {
    services = {
      swww-img = {
        Unit = {
          Description = "Change swww wallpaper";
        };
        Service = {
          Type = "oneshot";
          ExecStart = ../../scripts/swww-img.sh;
        };
        Install = {
          WantedBy = ["default.target"];
        };
      };
    };
    timers = {
      swww-img = {
        Unit = {
          Description = "Change swww wallpaper on an interval";
        };
        Timer = {
          OnCalendar = "*:0,30";
        };
        Install = {
          WantedBy = ["timers.target"];
        };
      };
    };
  };
}
