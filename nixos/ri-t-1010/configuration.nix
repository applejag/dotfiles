{ pkgs, pkgs-unstable, lib, ... }:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  networking.hostName = "ri-t-1010"; # Define your hostname.

  environment.variables = {
    GOPROXY = "https://nexus3.2rioffice.com/repository/go/,https://goproxy.io,https://proxy.golang.org,direct";
  };

  # Bees: btrfs de-duplication on the "nixos" drive
  services.beesd.filesystems."nixos" = {
    spec = "LABEL=nixos";
    hashTableSizeMB = 128;
    extraOptions = [ "--thread-count" "4" ];
  };
}
