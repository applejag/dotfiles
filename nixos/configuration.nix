# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running `nixos-help`).


{ pkgs, pkgs-unstable, pkgs-master, lib, helm-values-schema-json, ... }:

{
  imports = [
    # Include the results of the hardware scan.
    ./flatpak.nix
  ];

  # Let's not use latest kernel actually
  #boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.kernelParams = [ "preempt=full" ];

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

  # Pick only one of the below networking options.
  #networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager = {
    enable = true;  # Easiest to use and most distros use this by default.
    plugins = with pkgs; [
      networkmanager-openconnect
    ];
  };

  networking.hosts = {
    "52.204.183.147" = [ "lalia-berlin.com" ];
    "172.22.10.224" = [ "iphh-elk7-live.jsctool.com" ];
    "127.0.0.1" = [ "api.localhost" "backoffice.localhost" ];
    "10.0.0.2" = [ "japan" ];
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
    enable = false;
    drivers = with pkgs; [
      gutenprint
    ];
  };
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver
      libva-vdpau-driver # VDPAU driver for the VAAPI lib
      libvdpau-va-gl # VDPAU driver with OpenGL/VAAPI backend
      libvpx # WebM VP8/VP9 codec
    ];
  };

  # https://wiki.nixos.org/wiki/Displaylink
  #services.xserver.videoDrivers = [ "displaylink" "modesetting" ];

  security.pam.loginLimits = [{
    domain = "*";
    type = "soft";
    item = "nofile";
    value = "100000";
  }];

  # Enable sound.
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;

    extraConfig.pipewire."92-low-latency" = {
      "context.properties" = {
        "default.clock.allowed-rates" = [ 32000 44100 48000 96000 192000 ];
        "default.clock.rate" = 48000;
        "default.clock.quantum" = 512;
        "default.clock.min-quantum" = 128;
        "default.clock.max-quantum" = 2048;
      };
    };
  };

  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  services.hardware.bolt.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  services.displayManager.autoLogin.enable = true;
  services.displayManager.autoLogin.user = "kallefagerberg";

  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      libz
      zstd
      stdenv.cc.cc
      libgcc
      libcxx
      glib
      musl
    ];
  };

  programs.zsh = {
    enable = true;
    autosuggestions = {
      enable = true;
      async = true;
    };
    syntaxHighlighting = {
      enable = true;
      highlighters = ["main" "brackets" "pattern" "regexp" "root" "line"];
      # https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/docs/highlighters/pattern.md
      patterns = {
        "rm -rf *" = "fg=white,bold,bg=red";
      };
    };
  };

  programs.fish = {
    enable = true;
  };

  programs.evolution = {
    # GNOME email client
    enable = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.kallefagerberg = {
    isNormalUser = true;
    extraGroups = [
      "wheel" # Enable ‘sudo’ for the user.
      "libvirtd" # Run VMs without needing sudo
      "dialout" # Talk through serial for IoT
      "wireshark" # capture network dumps
      "networkmanager" # manage network connections
      "greeter" # greetd https://danklinux.com/docs/dankgreeter/configuration#manual-sync
    ];
    shell = pkgs.fish;
    packages =
    (with pkgs; [
      # GUI apps
      thunderbird-bin
      birdtray # tray icon for Thunderbird
      slack
      nextcloud-client
      spotify
      #emacs-git # Emacs 28+, for Doom Emacs
      #emacs29-pgtk
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
      tree-sitter # CLI for creating tree-sitter grammars
      viddy # watch alternative
      nh # nix helper CLI
      kind # Kubernetes in Docker
      minikube # Kubernetes in VMs or in Docker
      wrk # HTTP benchmark tool
      graphviz-nox # Graph making tools, without X11
      go-jsonnet # Go implementation of Jsonnet
      jsonnet-bundler # basically a package manager for jsonnet
      btop-rocm # better htop

      age # encryption
      direnv # load .envrc files
      nodejs_22
      deno # nodejs, but better

      # Dev tools
      gcc
      editorconfig-core-c

      # Shell
      zsh-forgit # git+fzf

      # Python
      poetry # dependency manager
      python3

      # Core libs
      coreutils # needed for Doom Emacs
      ffmpeg-full
      glibcLocales

    ]) ++ (with pkgs-unstable;
      let
        pkgs-go_1_25 = (extend (final: prev: {
          go = prev.go_1_25;
          buildGoModule = prev.buildGo125Module;
        }));
      in
      [
      #====== Unstable packages ======

      # GUI apps
      zed-editor
      alacritty
      onlyoffice-desktopeditors
      libreoffice

      # CLI tools
      sops
      opentofu # terraform alternative
      jwt-cli # jwt parser/encoder
      typos # typo checker: https://github.com/crate-ci/typos
      minio-client # mc

      mise # tool package manager
      usage # CLI completion tool, used by mise

      # Kubernetes
      kubecolor
      kubectl
      kubectl-klock # :D
      kubectl-cnpg # CloudNativePG (Postgres operator)
      kubectx
      kubelogin-oidc
      kubebuilder # operator CLI tool
      chart-testing
      argocd # ArgoCD CLI

      # Zig
      #zig
      #zls # Zig language server

      # Gleam
      #gleam

      # Go
      go_1_25
      gotools # e.g goimports
      pkgs-go_1_25.gofumpt # formatter
      pkgs-go_1_25.gopls # language server
      pkgs-go_1_25.golangci-lint # linter
      pkgs-go_1_25.delve # debugger

      gore # REPL
      gocode-gomod # autocompletion daemon
      revive # linter
      goreleaser # release tool
      gomodifytags # manipulate struct tags (e.g in Emacs)
      gotestsum
      govulncheck # SAST
      ko # builder

      # Linters
      shellcheck
      shfmt
      yamllint
      zizmor # github action security linter
      actionlint # github action syntax linter

      # Language servers
      typos-lsp # typo checker: https://github.com/tekumara/typos-lsp
      fish-lsp
      lua-language-server
      nixd
      nodePackages.bash-language-server
      nodePackages.typescript-language-server
      terraform-ls
      vscode-langservers-extracted
      yaml-language-server
      package-version-server
      jsonnet-language-server

    ]) ++ (
    let
      my-kubernetes-helm = with pkgs-unstable; wrapHelm kubernetes-helm {
        plugins = with kubernetes-helmPlugins; [
          helm-diff
          helm-secrets
          helm-values-schema-json
        ];
      };
    in [
      my-kubernetes-helm
      pkgs-unstable.helm-ls
    ]);
  };

  fonts.packages = (with pkgs; [
    noto-fonts
    noto-fonts-color-emoji
    ubuntu-classic
    font-awesome
    intel-one-mono
    nerd-fonts.fira-code # FiraCode
    nerd-fonts.intone-mono # IntoneMono (Intel One Mono)
    nerd-fonts.fantasque-sans-mono # used in Waybar config
  ]) ++ (with pkgs-unstable; [
    monocraft
    miracode # monocraft but vectorized
  ]);

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    curl
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
    #"displaylink"
    "slack"
    "spotify"
    "steam"
    "steam-original"
    "steam-run"
    "steam-unwrapped"
    "vault" # used by helm-secrets
  ];

  programs.wireshark.enable = true;
  programs.wireshark.package = pkgs.wireshark;

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
  programs.virt-manager.enable = true;

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
  networking.firewall.allowedTCPPortRanges = [
    { from = 8000; to = 8100; }
    { from = 10000; to = 20000; }
  ];
  networking.firewall.allowedUDPPortRanges = [
    { from = 8000; to = 8100; }
    { from = 10000; to = 20000; }
  ];

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
  system.stateVersion = "24.05"; # Did you read the comment?
}
