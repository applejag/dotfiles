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
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --user-menu --asterisks --remember --remember-session --time";
        user = "greeter";
      };
    };
  };

  users.users.kallefagerberg = {
    packages = with pkgs; [
      wl-clipboard # paste to clipboard
    ];
  };
}
