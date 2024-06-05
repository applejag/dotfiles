{ config, pkgs, lib, username, ... }:

let
  fromGitHub = ref: repo: pkgs.vimUtils.buildVimPlugin {
    pname = "${lib.strings.sanitizeDerivationName repo}";
    version = ref;
    src = builtins.fetchGit {
      url = "https://github.com/${repo}.git";
      ref = ref;
    };
  };
  fromLocal = path: pkgs.vimUtils.buildVimPlugin {
    pname = "${lib.strings.sanitizeDerivationName (baseNameOf path)}";
    version = "local";
    src = builtins.fetchGit {
      url = path;
    };
  };
in
{
  home.username = username;
  home.homeDirectory = "/home/${username}";

  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "vscode"
  ];

  programs.firefox = {
    enable = true;
    package = pkgs.firefox.override {
      cfg = {
        ffmpegSupport = true;
        pipewireSupport = true;
      };
    };
  };

  programs.bash = {
    enable = true;
    bashrcExtra = ''
      eval "$(direnv hook bash)"
    '';
  };

  # Seems to be bugged until https://github.com/NixOS/nixpkgs/pull/267878
  # can get merged into unstable
  programs.awscli = {
    enable = true;
    settings = {
      "profile frida-prod" = {
        "credential_process" = "/home/kallefagerberg/dotfiles/scripts/op-aws-cred.sh 325jrwwckodnkxxpwchjojk35i";
      };
      "profile frida-dev" = {
        "credential_process" = "/home/kallefagerberg/dotfiles/scripts/op-aws-cred.sh vib37uxuuj4tryrbqairhhc7yy";
      };
      "profile platform-playground" = {
        "credential_process" = "/home/kallefagerberg/dotfiles/scripts/op-aws-cred.sh 6rfhu4wjjzgaivzuroixhxjacq";
      };
      "profile identiq-dev" = {
        "credential_process" = "/home/kallefagerberg/dotfiles/scripts/op-aws-cred.sh 2mftaukxoesjxf33q6j5dyukci";
      };
    };
  };

  programs.neovim = {
    enable = true;
    defaultEditor = true;

    plugins = with pkgs.vimPlugins; [
      nvim-lspconfig # configs for common LSP servers

      nvim-cmp # completion engine
      cmp-nvim-lsp # completion from language server
      cmp-nvim-lsp-signature-help # completion for functions
      cmp-buffer # completion for words from buffers
      cmp-path # completion for paths
      cmp-git # completion for commits, PRs, user mentions
      nvim-snippy # snippets plugin
      cmp-snippy # completion for snippets (provided by e.g LSP)
      lspkind-nvim # VS Code-like icons

      nvim-surround
      guess-indent-nvim
      dracula-nvim # theme
      plenary-nvim # utility Lua functions used by other plugins
      vim-mustache-handlebars # {{ templates }}
      vim-helm # gotmpl
      nvim-sops # SOPS integration
      which-key-nvim # help popup on keybindings
      nvim-treesitter
      nvim-treesitter-refactor
      nvim-treesitter-parsers.astro
      nvim-treesitter-parsers.bash
      nvim-treesitter-parsers.comment
      nvim-treesitter-parsers.css
      nvim-treesitter-parsers.cue
      nvim-treesitter-parsers.dockerfile
      nvim-treesitter-parsers.fish
      nvim-treesitter-parsers.git_config
      nvim-treesitter-parsers.git_rebase
      nvim-treesitter-parsers.gitattributes
      nvim-treesitter-parsers.gitcommit
      nvim-treesitter-parsers.gitignore
      nvim-treesitter-parsers.go
      nvim-treesitter-parsers.gomod
      nvim-treesitter-parsers.gosum
      nvim-treesitter-parsers.gowork
      nvim-treesitter-parsers.hcl
      nvim-treesitter-parsers.html
      nvim-treesitter-parsers.ini
      nvim-treesitter-parsers.javascript
      nvim-treesitter-parsers.jq
      nvim-treesitter-parsers.json
      nvim-treesitter-parsers.json5
      nvim-treesitter-parsers.jsonc
      nvim-treesitter-parsers.lua
      nvim-treesitter-parsers.make
      nvim-treesitter-parsers.markdown
      nvim-treesitter-parsers.markdown_inline
      nvim-treesitter-parsers.mermaid
      nvim-treesitter-parsers.nix
      nvim-treesitter-parsers.org
      nvim-treesitter-parsers.passwd
      nvim-treesitter-parsers.python
      nvim-treesitter-parsers.regex
      nvim-treesitter-parsers.requirements
      nvim-treesitter-parsers.rst
      nvim-treesitter-parsers.scala
      nvim-treesitter-parsers.sql
      nvim-treesitter-parsers.ssh_config
      nvim-treesitter-parsers.terraform
      nvim-treesitter-parsers.typescript
      nvim-treesitter-parsers.vhs
      nvim-treesitter-parsers.vimdoc
      nvim-treesitter-parsers.yaml
      nvim-treesitter-parsers.zig
      #(fromGitHub "HEAD" "vrischmann/tree-sitter-templ")
      indent-blankline-nvim
    ];
    extraPackages = with pkgs; [
      helm-ls
      lua-language-server
      nixd
      nodePackages.typescript-language-server
      terraform-ls
    ];
  };

  programs.vscode = {
    enable = true;
    userSettings = {
      # Crashes on launch in Hyprland without this.
      # https://github.com/microsoft/vscode/issues/181533#issuecomment-1597187136
      "window.titleBarStyle" = "custom";
      "diffEditor.ignoreTrimWhitespace" = false;
      "files.watcherExclude" = {
        "**/.bloop" = true;
        "**/.metals" = true;
        "**/.ammonite" = true;
      };
      "cSpell.userWords" = [
        "sasl" # Simple Authentication Security Layer
        "jaas" # Java Authentication and Authorization Service
      ];
      "editor.rulers" = [
        80
      ];
    };
    extensions = with pkgs.vscode-extensions; [
      bierner.markdown-mermaid
      christian-kohler.path-intellisense
      davidanson.vscode-markdownlint
      dbaeumer.vscode-eslint
      dracula-theme.theme-dracula
      editorconfig.editorconfig
      redhat.vscode-yaml
      streetsidesoftware.code-spell-checker
      vscodevim.vim
    ];
  };

  home.file."init.lua" = {
    source = ../nvim/init.lua;
    target = ".config/nvim/init.lua";
  };

  programs.git = {
    enable = true;

    signing.key = "748D7ADC975211B2";
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
      pull = {
        # Default to merge when doing pull
        rebase = false;
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

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
    # https://nixos.wiki/wiki/Virt-manager
    "org/virt-manager/virt-manager/connections" = {
      autoconnect = ["qemu:///system"];
      uris = ["qemu:///system"];
    };
  };

  gtk = {
    enable = true;
    theme = {
      name = "Catppuccin-Macchiato-Compact-Teal-Dark";
      package = pkgs.catppuccin-gtk.override {
        accents = [ "teal" ];
        size = "compact";
        tweaks = [ "rimless" "black" ];
        variant = "macchiato";
      };
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
    platformTheme.name = "kde";
    style = {
      name = "kvantum";
      package = with pkgs; [
        libsForQt5.qtstyleplugin-kvantum
        kdePackages.qtstyleplugin-kvantum
        kdePackages.breeze-icons
      ];
    };
  };

  xdg.mimeApps = {
    enable = true;
    # Find names of applications installed by Nix in ~/.nix-profile/share/applications
    # Flatpak apps are visible at /var/lib/flatpak/exports/share/applications
    defaultApplications = {
      # Firefox
      "application/pdf" = "firefox.desktop";
      "x-scheme-handler/http" = "firefox.desktop";
      "x-scheme-handler/https" = "firefox.desktop";
      "text/html" = "firefox.desktop";
      # Thunderbird
      "application/x-extension-ics" = "thunderbird.desktop";
      "message/rfc822" = "thunderbird.desktop";
      "text/calendar" = "thunderbird.desktop";
      "x-scheme-handler/mailto" = "thunderbird.desktop";
      "x-scheme-handler/mid" = "thunderbird.desktop";
      "x-scheme-handler/webcal" = "thunderbird.desktop";
      "x-scheme-handler/webcals" = "thunderbird.desktop";
      # Dolphin
      "inode/directory" = "org.kde.dolphin.desktop";
      "application/x-directory" = "org.kde.dolphin.desktop";

      # Text files
      "application/json" = "nvim.desktop";
      "application/yaml" = "nvim.desktop";
      "text/markdown" = "nvim.desktop";
      "text/x-csrc" = "nvim.desktop";
      "text/plain" = "nvim.desktop";
    };
    associations.added = {
      # Thunderbird
      "x-scheme-handler/mailto" = "thunderbird.desktop";
      "x-scheme-handler/mid" = "thunderbird.desktop";
      "x-scheme-handler/webcal" = "thunderbird.desktop";
      "x-scheme-handler/webcals" = "thunderbird.desktop";
    };
  };
  xdg.configFile = {
    "gtk-4.0/assets".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/assets";
    "gtk-4.0/gtk.css".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/gtk.css";
    "gtk-4.0/gtk-dark.css".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/gtk-dark.css";
  };

  
  xdg.dataFile = let
    nodeVersion = "node-v18.15.0-linux-x64";
    nodePackage = pkgs.nodejs_18;
  in {
    "zed/node/${nodeVersion}/bin".source = "${nodePackage}/bin";
    "zed/node/${nodeVersion}/include".source = "${nodePackage}/include";
    "zed/node/${nodeVersion}/lib".source = "${nodePackage}/lib";
    "zed/node/${nodeVersion}/share".source = "${nodePackage}/share";
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
