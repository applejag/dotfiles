{ pkgs, ... }:

{
  programs.hyprland.enable = true;

  # Hint electron apps to use Wayland
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  security.pam.services.swaylock.text = ''
    auth include login
  '';

  services.greetd = {
    settings = {
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --user-menu --asterisks --remember --remember-session --time --cmd Hyprland";
        user = "greeter";
      };
    };
  };

  users.users.kallefagerberg = {
    packages = with pkgs; [
      # Desktop environment
      xdg-desktop-portal-hyprland # screen share
      hyprpaper # wallpaper

      alsa-utils # tools like amixer to control audio
      brightnessctl # screen brightness
      #pwvucontrol # Pipewire volume control
      pavucontrol # PulseAudio volume control
      swayidle # detects idle
      swaylock-effects # swaylock fork with better effects
      rofi # runner
      wlopm # power management (turn off monitors)
      wlogout # logout screen
      swaynotificationcenter
      libsForQt5.qtstyleplugin-kvantum

      slurp # select region
      grim # take screenshot
      swappy # edit screenshot
      wl-clipboard # paste to clipboard

      # Core libs
      libsForQt5.qt5.qtwayland
      qt6.qtwayland
      xwayland
    ];
  };
}
