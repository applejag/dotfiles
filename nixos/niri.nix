{ pkgs, pkgs-unstable, pkgs-master, ... }:

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

  users.users.kallefagerberg = {
    packages = (with pkgs; [
      # Desktop environment
      kdePackages.elisa
      #kdePackages.dolphin # KDE file manager
      #kdePackages.kdialog # KDE file picker
      networkmanagerapplet # NetworkManager (nm-applet)


    ]) ++ (with pkgs-unstable; [
      alsa-utils # tools like amixer to control audio
      brightnessctl # screen brightness
      # TODO: Change back to pkgs-unstable when this is available in nixpkgs-unstable:
      # https://github.com/NixOS/nixpkgs/commit/729fa0f994cdb42f87a543075a7e72948d8d8e6e
      pkgs-master.pwvucontrol # Pipewire volume control
      #pavucontrol # PulseAudio volume control
      swww # wallpaper
      swayidle # detects idle
      hyprlock # lock screen
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

  security.polkit.enable = true;

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
}
