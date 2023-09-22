{ config, pkgs, lib, ... }:

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
{
  home.username = "kallefagerberg";
  home.homeDirectory = "/home/kallefagerberg";

  home.packages = with pkgs; [
    # GUI apps
    firefox
    thunderbird
    alacritty
    slack
    nextcloud-client
    libsForQt5.elisa
    libsForQt5.index # MAUI file manager
    libsForQt5.clip # MAUI video player (using mpv)
    spotify

    # CLI tools
    bat # better cat
    delta # git diff syntax highlight
    eza # fork of exa, better ls
    fd # better find
    fzf # fuzzy find
    gh # GitHub CLI
    git
    git-crypt
    git-lfs
    jq
    yq-go
    libnotify # notify-send
    neovim
    podman-compose # podman is already installed via /etc/nixos/configuration.nix
    ripgrep
    dig # network tool
    tmux
    navi

    age # encryption
    direnv # load .envrc files
    sops
    terraform
    terraform-ls
    nodejs_20

    # Linters
    shellcheck
    shfmt
    yamllint

    # Kubernetes
    kubectl
    kubectl-klock # :D
    kubectl-gadget # inspector-gadget
    kubectx
    kubelogin-oidc
    my-kubernetes-helm
    my-helmfile

    # Python
    poetry # dependency manager
    python311

    # Shell
    carapace # completions
    starship # prompt
    zsh
    zsh-forgit # git+fzf

    # Go
    go_1_21
    gotools # e.g goimports
    gopls # language server
    gore # REPL
    gocode # for code completion
    revive # linter
    golangci-lint # linter
    (callPackage ./govulncheck.nix {}) # SAST
    
    # Dev tools
    gcc

    # Desktop environment
    xdg-desktop-portal-hyprland # screen share
    hyprpaper # wallpaper

    alsa-utils # tools like amixer to control audio
    brightnessctl # screen brightness
    networkmanagerapplet # NetworkManager (nm-applet)
    #pwvucontrol # Pipewire volume control
    pavucontrol # PulseAudio volume control
    swayidle # detects idle
    swaylock-effects # swaylock fork with better effects
    rofi # runner
    wlopm # power management (turn off monitors)
    wlogout # logout screen
    swaynotificationcenter
    libsForQt5.qtstyleplugin-kvantum

    slurp # select region
    grim # take screenshot
    swappy # edit screenshot
    wl-clipboard # paste to clipboard

    # Auth
    pinentry-qt
    libsForQt5.polkit-kde-agent

    # Core libs
    libsForQt5.qt5.qtwayland
    qt6.qtwayland
    xwayland
  ];

  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "slack"
    "spotify"
  ];

  programs.bash = {
    enable = true;
    bashrcExtra = ''
      eval "$(direnv hook bash)"
    '';
  };

  programs.git = {
    enable = true;

    signing.key = "9874DEDD35925ED0";
    signing.signByDefault = true;
    lfs.enable = true;

    userName = "Kalle Fagerberg";
    userEmail = "kalle.fagerberg@riskident.com";

    aliases = {
      ss = "status --short";
      root = "rev-parse --show-toplevel";
    };

    extraConfig = {
      tag = {
        forceSignAnnotated = true;
      };
      init = {
        defaultBranch = "main";
      };
      core = {
        # https://github.com/dandavison/delta
        pager = "delta";
      };
      interactive = {
        diffFilter = "delta --color-only";
      };
      delta = {
        navigate = true; # use n and N to move between diff sections
	light = false; # set to true when using terminal w/ light background color
	syntax-theme = "TwoDark";
      };
      diff = {
        "ansible-vault" = {
	  textconv = "PAGER=cat ansible-vault view";
	  cachetextconv = true;
	};
      };
      url = {
        "ssh://git@github.2rioffice.com/" = {
	  insteadOf = "https://github.2rioffice.com";
	};
      };
    };
  };

  systemd.user.services."dinkur" = {
    Unit.Description = "Dinkur daemon";
    Install.WantedBy = ["default.target"];
    Service = {
      Type = "simple";
      Restart = "always";
      RestartSec = 1;
      ExecStart = "%h/go/bin/dinkur daemon -v";
    };
  };

  # Hint electron apps to use Wayland
  home.sessionVariables.NIXOS_OZONE_WL = "1";

  wayland.windowManager.hyprland = {
    enable = true;
    extraConfig = builtins.readFile ../hypr/hyprland.conf;
    systemdIntegration = true;
  };

  home.file."hyprpaper.conf" = {
    source = ../hypr/hyprpaper.conf;
    target = ".config/hypr/hyprpaper.conf";
  };

  programs.waybar = {
    enable = true;
    settings = import ../waybar/config.nix;
    style = ../waybar/style.css;
  };

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
  };

  gtk = {
    enable = true;
    theme = {
      name = "Juno";
      package = pkgs.juno-theme;
    };

    cursorTheme = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Ice";
    };

    gtk3 = {
      bookmarks = [
        "file:///home/kallefagerberg/Downloads"
        "file:///home/kallefagerberg/Documents"
        "file:///home/kallefagerberg/code"
        "file:///home/kallefagerberg/code/risk.ident"
        "file:///home/kallefagerberg/code/risk.ident/platform"
      ];

      extraConfig = {
        Settings = ''
	  gtk-application-prefer-dark-theme=1
	'';
      };
    };

    gtk4 = {
      extraConfig = {
        Settings = ''
          gtk-application-prefer-dark-theme=1
        '';
      };
    };
  };

  home.sessionVariables.GTK_THEME = "Juno";

  qt = {
    enable = true;
    platformTheme = "kde";
    style = {
      name = "kvantum";
      package = with pkgs; [
        libsForQt5.qtstyleplugin-kvantum
        qt6Packages.qtstyleplugin-kvantum
        libsForQt5.breeze-icons
      ];
    };
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
