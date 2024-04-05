{ pkgs, ... }:
{
  services.desktopManager.plasma6.enable = true;

  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    konsole
    kate
  ];

  services.greetd = {
    settings = {
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --user-menu --asterisks --remember --remember-session --time --sessions ${pkgs.kdePackages.plasma-workspace.outPath}/share/wayland-sessions";
        user = "greeter";
      };
    };
  };

  users.users.kallefagerberg = {
    packages = with pkgs; [
      wl-clipboard # paste to clipboard

      kdePackages.kscreen
      kdePackages.libkscreen

      # Name is libsForQt5, but it works for KDE 6
      (libsForQt5.polonium.overrideAttrs {
        version = "v1.0rc";
      })
    ];
  };
}
