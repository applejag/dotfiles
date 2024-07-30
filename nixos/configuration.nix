# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running `nixos-help`).


{ config, pkgs, lib, ... }:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./flatpak.nix
  ];

  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.plymouth = {
    enable = true;
    theme = "catppuccin-macchiato";
    themePackages = with pkgs; [
      catppuccin-plymouth
    ];
  };
  boot.initrd.systemd.enable = true;

  boot.tmp.cleanOnBoot = true;

  networking.hostName = "ri-t-0788"; # Define your hostname.
  # Pick only one of the below networking options.
  #networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  networking.hosts = {
    "52.204.183.147" = [ "lalia-berlin.com" ];
  };

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.supportedLocales = [ "all" ];
  i18n.extraLocaleSettings = {
    LC_CTYPE = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_TIME = "sv_SE.UTF-8";
    LC_COLLATE = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_MESSAGES = "en_US.UTF-8";
    LC_PAPER = "sv_SE.UTF-8";
    LC_NAME = "sv_SE.UTF-8";
    LC_ADDRESS = "de_DE.UTF-8";
    LC_TELEPHONE = "sv_SE.UTF-8";
    LC_MEASUREMENT = "sv_SE.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
  };
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkbOptions in tty.
  # };

  # Enable the X11 windowing system.
  # services.xserver.enable = true;

  # Configure keymap in X11
  # services.xserver.layout = "us";
  # services.xserver.xkbOptions = "eurosign:e,caps:escape";

  # Enable CUPS to print documents.
  services.printing = {
    enable = true;
    drivers = with pkgs; [
      gutenprint
    ];
  };
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  # Bees: btrfs de-duplication on the "nixos" drive
  services.beesd.filesystems."nixos" = {
    spec = "LABEL=nixos";
    hashTableSizeMB = 128;
  };

  # Hardware-accelerated video encoding/decoding
  # https://nixos.wiki/wiki/Accelerated_Video_Playback
  nixpkgs.config.packageOverrides = pkgs: {
    vaapiIntel = pkgs.vaapiIntel.override { enableHybridCodec = true; };
  };

  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver
      vaapiIntel # older but works better for Firefox/Chromium
      vaapiVdpau # VDPAU driver for the VAAPI lib
      libvdpau-va-gl # VDPAU driver with OpenGL/VAAPI backend
      libvpx # WebM VP8/VP9 codec
    ];
  };

  # Enable sound.
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    # This should be supported, but I get error:
    # "The option `services.pipewire.alsa.support32bit' does not exist."
    #alsa.support32bit = true;
    pulse.enable = true;
  };

  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  services.hardware.bolt.enable = true;

  services.greetd = {
    # https://man.sr.ht/~kennylevinsen/greetd/
    enable = true;
  };
  environment.etc."greetd/environments".text = ''
    zsh
    plasma
    Hyprland
  '';

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.kallefagerberg = {
    isNormalUser = true;
    extraGroups = [
      "wheel" # Enable ‘sudo’ for the user.
      "libvirtd" # Run VMs without needing sudo
      "dialout" # Talk through serial for IoT
    ];
    packages =
    let
      my-kubernetes-helm = with pkgs; wrapHelm kubernetes-helm {
        plugins = with pkgs.kubernetes-helmPlugins; [
          helm-diff
          helm-secrets
        ];
      };
      my-helmfile = with pkgs; helmfile-wrapped.override {
        inherit (my-kubernetes-helm.passthru) pluginsDir;
      };
    in
    with pkgs; [
      # GUI apps
      thunderbird
      birdtray # tray icon for Thunderbird
      alacritty
      slack
      nextcloud-client
      kdePackages.elisa
      kdePackages.dolphin # KDE file manager
      kdePackages.kdialog # KDE file picker
      spotify
      onlyoffice-bin
      #emacs-git # Emacs 28+, for Doom Emacs
      #emacs29-pgtk
      virt-manager
      zed-editor
      #hedgewars # TODO: reenable, but for now it fails to build
      inkscape

      # CLI tools
      zip
      unzip
      bat # better cat
      delta # git diff syntax highlight
      eza # fork of exa, better ls
      fd # better find
      fzf # fuzzy find
      gh # GitHub CLI
      git-crypt
      git-lfs
      jq
      yq-go
      libnotify # notify-send
      podman-compose # podman is already installed via /etc/nixos/configuration.nix
      ripgrep
      dig # network tool
      tmux
      navi # alias/shortcut utility
      slides # presentation tool
      openssl
      reuse # license linter
      risor # Go scripting language
      tree-sitter # CLI for creating tree-sitter grammars
      viddy # watch alternative
      charm-freeze
      nh # nix helper CLI

      age # encryption
      direnv # load .envrc files
      sops
      opentofu # terraform alternative
      nodejs_20

      # Kubernetes
      kubectl
      kubectl-klock # :D
      kubectl-gadget # inspector-gadget
      kubectl-cnpg # CloudNativePG (Postgres operator)
      kubectx
      kubelogin-oidc
      kubecolor # kubectl wrapper that adds colors
      my-kubernetes-helm
      my-helmfile
      stern # logs aggregator
      kubebuilder # operator CLI tool

      # Linters
      shellcheck
      shfmt
      yamllint

      # Language servers
      helm-ls
      lua-language-server
      nixd
      nodePackages.bash-language-server
      nodePackages.typescript-language-server
      terraform-ls
      vscode-langservers-extracted
      yaml-language-server

      # Go
      go_1_21
      gotools # e.g goimports
      gofumpt # formatter
      gopls # language server
      gore # REPL
      revive # linter
      golangci-lint # linter
      gomodifytags # manipulate struct tags (e.g in Emacs)
      gotestsum
      govulncheck # SAST
      templ # HTML templating
      cue # config language

      # Zig
      zig
      zls # Zig language server

      # Gleam
      gleam
      erlang_nox

      # Dev tools
      gcc
      editorconfig-core-c

      # Shell
      carapace # completions
      starship # prompt
      zsh
      zsh-forgit # git+fzf

      # Python
      poetry # dependency manager
      python311

      # Core libs
      coreutils # needed for Doom Emacs
      ffmpeg-full
      glibcLocales
    ];
  };

  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-emoji
    monocraft
    ubuntu_font_family
    font-awesome
    intel-one-mono
    (nerdfonts.override { fonts = [ "FiraCode" "IntelOneMono" ]; })
  ];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    curlHTTP3
    file
    git
    gnumake
    htop
    killall
    neovim
    wget
    xdg-utils
  ];


  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "1password"
    "1password-cli"
    "slack"
    "spotify"
    "vault" # used by helm-secrets
    "steam"
    "steam-original"
    "steam-run"
  ];

  programs._1password.enable = true;
  programs._1password-gui.enable = true;
  programs._1password-gui.polkitPolicyOwners = [ "kallefagerberg" ];

  programs.steam = {
    enable = true;
    package = with pkgs; steam.override { extraPkgs = pkgs: [ attr ]; };
  };

  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
  };
  # For virt-manager
  # https://nixos.wiki/wiki/Virt-manager
  virtualisation.libvirtd.enable = true;
  programs.dconf.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    #enableSSHSupport = true;
  };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  services.auto-cpufreq.enable = lib.mkDefault true;

  services.fwupd.enable = true;

  services.clamav = {
    daemon.enable = true;
    updater.enable = true;
    scanner.enable = true;
    fangfrisch.enable = true;
  };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = true;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # Not supported when using flakes.
  #system.copySystemConfiguration = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?

  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
  };

  nix.buildMachines = [{
    hostName = "superburk";
    system = "x86_64-linux";
    protocol = "ssh-ng";
    maxJobs = 3;
    speedFactor = 4;
    supportedFeatures = [ ];
    mandatoryFeatures = [ ];
  }];
  nix.distributedBuilds = true;
  nix.extraOptions = ''
    builders-use-substitutes = true
  '';

}
