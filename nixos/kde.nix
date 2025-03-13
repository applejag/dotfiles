{ pkgs, pkgs-unstable, ... }:
{

  services.xserver.enable = true;
  services.desktopManager.plasma6.enable = true;
  services.displayManager.sddm.enable = true;
  services.displayManager.defaultSession = "plasma";
  services.displayManager.sddm.wayland.enable = true;

  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    konsole
    kate
  ];

  services.greetd.enable = false;

  users.users.kallefagerberg = {
    packages = (with pkgs; [
      wl-clipboard # paste to clipboard

      # Name is libsForQt5, but it works for KDE 6
      #(libsForQt5.polonium.overrideAttrs {
      #  version = "47476380c587522cc1b2eb98aacd35a3c9e69241";
      #})

      kde-rounded-corners # window borders theme
    ]);
  };
}
