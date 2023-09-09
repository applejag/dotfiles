{ config, pkgs, lib, ... }:

{
  home.username = "kallefagerberg";
  home.homeDirectory = "/home/kallefagerberg";

  home.packages = with pkgs; [
    # GUI apps
    firefox
    thunderbird
    alacritty
    _1password-gui
    slack

    # CLI tools
    bat
    exa
    fd
    fzf
    gh
    git
    jq
    neovim
    ripgrep

    age
    direnv
    kubectl
    kubectx
    kubelogin-oidc
    sops
    terraform

    # Shell
    carapace
    starship
    zsh
    zsh-forgit

    # Go
    go
    gopls # language server
    gore # REPL
    gocode # for code completion
    revive # linter
    golangci-lint # linter
    
    # Dev tools
    gcc

    # Desktop environment
    xdg-desktop-portal-hyprland # screen share
    hyprpaper # wallpaper

    alsa-utils # tools like amixer to control audio
    brightnessctl # screen brightness
    networkmanagerapplet # NetworkManager (nm-applet)
    pwvucontrol # Pipewire volume control
    swayidle # detects idle
    swaylock-effects # swaylock fork with better effects
    tofi # runner
    waybar # taskbar
    wlopm # power management (turn off monitors)

    # Auth
    pinentry-qt
    libsForQt5.polkit-kde-agent

    # Core libs
    libsForQt5.qt5.qtwayland
    qt6.qtwayland
  ];

  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "1password"
    "slack"
  ];

  # Hint electron apps to use Wayland
  home.sessionVariables.NIXOS_OZONE_WL = "1";

  wayland.windowManager.hyprland = {
    enable = true;
    extraConfig = ''
      # test test helloworld
      '';
    systemdIntegration = true;
  };

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "23.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
