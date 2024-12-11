{ pkgs, pkgs-unstable, username, ... }:

{
  programs.niri = {
    enable = true;
  };

  # Hint electron apps to use Wayland
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  #security.pam.services.swaylock.text = ''
  #  auth include login
  #'';
  security.pam.services.hyprlock = {};

  services.greetd = {
    settings = {
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --user-menu --asterisks --remember --remember-session --time --cmd niri-session";
        user = "greeter";
      };
    };
  };

  users.users.${username} = {
    packages = (with pkgs; [
      # Desktop environment
      kdePackages.elisa
      #kdePackages.dolphin # KDE file manager
      #kdePackages.kdialog # KDE file picker
      networkmanagerapplet # NetworkManager (nm-applet)

      # Some Cosmic apps to complement
      cosmic-applets
      cosmic-icons
      cosmic-notifications
      cosmic-panel
      cosmic-settings
      cosmic-settings-daemon
      cosmic-wallpapers
      hicolor-icon-theme
      pop-icon-theme
      pop-launcher
      xdg-user-dirs

    ]) ++ (with pkgs-unstable; [
      alsa-utils # tools like amixer to control audio
      brightnessctl # screen brightness
      pwvucontrol # Pipewire volume control
      #pavucontrol # PulseAudio volume control
      swww # wallpaper
      swayidle # detects idle
      swaylock-effects # swaylock fork with better effects
      wlopm # power management (turn off monitors)
      wlogout # logout screen
      swaynotificationcenter
      fuzzel # runner
      wl-clipboard # paste to clipboard
      xwayland-satellite # rootless xwayland
    ]);
  };

  services.gnome.gnome-keyring.enable = true;
  programs.seahorse.enable = true;

  # KDE polkit
  systemd.user.services.polkit-gnome-authentication-agent-1 = {
    description = "polkit-gnome-authentication-agent-1";
    wantedBy = [ "graphical-session.target" ];
    wants = [ "graphical-session.target" ];
    after = [ "graphical-session.target" ];
    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
      Restart = "on-failure";
      RestartSec = 1;
      TimeoutStopSec = 10;
    };
  };

  programs.gnupg.agent.pinentryPackage = pkgs.pinentry-gnome3;

  # required dbus services by Cosmic DE (and basically good to have services)
  programs.dconf.enable = true;
  services.accounts-daemon.enable = true;
  services.upower.enable = true;
  security.polkit.enable = true;
  security.rtkit.enable = true;

  xdg.mime.enable = true;
  xdg.icons.enable = true;
  services.libinput.enable = true;

  environment.pathsToLink = [
    "/share/backgrounds"
    "/share/cosmic"
  ];
}
