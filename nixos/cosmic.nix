{ pkgs, ... }:

{
  services.desktopManager.cosmic.enable = true;
  services.displayManager.cosmic-greeter.enable = true;

  # Collides with services.power-profiles-daemon.enable, which comes shipped with nixos-cosmic
  services.auto-cpufreq.enable = false;
}
