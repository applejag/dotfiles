{
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.users.kallefagerberg = import ../home-manager/home.nix;
}
