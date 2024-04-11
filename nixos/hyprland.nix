{ pkgs, ... }:

{
  programs.hyprland.enable = true;

  # Hint electron apps to use Wayland
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  #security.pam.services.swaylock.text = ''
  #  auth include login
  #'';
  security.pam.services.hyprlock = {};

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
      hyprlock # screen lock
      hypridle # detects idle

      networkmanagerapplet # NetworkManager (nm-applet)

      alsa-utils # tools like amixer to control audio
      brightnessctl # screen brightness
      #pwvucontrol # Pipewire volume control
      pavucontrol # PulseAudio volume control
      #swayidle # detects idle
      #swaylock-effects # swaylock fork with better effects
      rofi # runner
      wlopm # power management (turn off monitors)
      wlogout # logout screen
      swaynotificationcenter
      kdePackages.qtstyleplugin-kvantum

      slurp # select region
      grim # take screenshot
      swappy # edit screenshot
      wl-clipboard # paste to clipboard

      # Auth
      pinentry-qt
      kdePackages.polkit-kde-agent-1

      # Core libs
      libsForQt5.qt5.qtwayland
      qt6.qtwayland
      xwayland
    ];
  };

  services.gnome.gnome-keyring.enable = true;
  programs.seahorse.enable = true;

  security.polkit.enable = true;

  # KDE polkit
  systemd.user.services.polkit-kde-authentication-agent-1 = {
    description = "polkit-kde-authentication-agent-1";
    wantedBy = [ "graphical-session.target" ];
    wants = [ "graphical-session.target" ];
    after = [ "graphical-session.target" ];
    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.kdePackages.polkit-kde-agent-1}/libexec/polkit-kde-authentication-agent-1";
      Restart = "on-failure";
      RestartSec = 1;
      TimeoutStopSec = 10;
    };
  };
}
