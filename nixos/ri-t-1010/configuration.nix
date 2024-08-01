{ pkgs, pkgs-unstable, lib, ... }:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  networking.hostName = "ri-t-1010"; # Define your hostname.

  # Bees: btrfs de-duplication on the "nixos" drive
  services.beesd.filesystems."nixos" = {
    spec = "LABEL=nixos";
    hashTableSizeMB = 128;
  };
}
