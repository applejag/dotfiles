{ config, pkgs, pkgs-unstable, lib, username, ... }:
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

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.zsh = {
    enable = true;
    autocd = true;
    initExtra = ''
      compdef kubecolor=kubectl

      autoload -Uz select-word-style
      select-word-style normal
      # default: '*?_-.[]~=/&;!#$%^(){}<>'
      WORDCHARS='*?~#$%^'
    '';
    #autosuggestion.enable = true;
    completionInit = "";

    dirHashes = {
      "." = "$HOME/dotfiles";
      "c" = "$HOME/code";
      "g" = "$HOME/code/gh";
      "gri" = "$HOME/code/gh/RiskIdent";
      "j" = "$HOME/code/gh/applejag";
      "a" = "$HOME/code/gh/applejag";
      "ri" = "$HOME/code/ri";
      "rif" = "$HOME/code/ri/frida";
      "rip" = "$HOME/code/ri/platform";
      "rik" = "$HOME/code/ri/kalle-fagerberg";
    };
    shellAliases = let
      kubectl-abbrs = moniker: resource: {
        "kdel${moniker}" = "kubectl delete ${resource}";
        "kd${moniker}" = "kubectl describe ${resource}";
        "ke${moniker}" = "kubectl edit ${resource}";
        "kw${moniker}" = "kubectl klock ${resource}";
        "kw${moniker}A" = "kubectl klock ${resource} --all-namespaces";
        "kg${moniker}" = "kubectl get ${resource}";
        "kg${moniker}A" = "kubectl get ${resource} --all-namespaces";
      };
    in lib.mkMerge [{
      grep = "grep --color";
      cat = "bat --decorations never";
      ls = "exa --color=always --group-directories-first -al --icons --git";

      p = "podman";
      docker = "podman";

      u = "dinkur";
      uy = "dinkur ls -r yesterday";
      ud = "dinkur ls -r today";
      uw = "dinkur ls -r week";
      ulw = "dinkur ls -r lastweek";
      ua = "dinkur ls -r all";

      tf = "tofu";
      tfi = "tofu init";
      tfa = "tofu apply";
      tfd = "tofu destroy";
      tfp = "tofu plan";
      tfo = "tofu output";

      a = "ansible";
      ag = "ansible-galaxy";
      ai = "ansible-inventory";
      ap = "ansible-playbook";
      av = "ansible-vault";
      avc = "ansible-vault create";
      ave = "ansible-vault edit";
      avv = "ansible-vault view";

      # Additional git aliases
      gla = "git pull --all --prune --jobs=10";
      # Resetting weird Forgit aliases
      gro = "cd $(git rev-parse --show-toplevel)";

      kc = "kubectx";
      kn = "kubens";

      kubectl = "kubecolor";
      k = "kubectl";
      kd = "kubectl describe";
      kg = "kubectl get";
      kw = "kubectl klock";
      ke = "kubectl edit";
      kdel = "kubectl delete";
      kdelf = "kubectl delete -f";
      kcf = "kubectl create -f";
      krf = "kubectl replace -f";
      krr = "kubectl rollout restart";
      krrd = "kubectl rollout restart deployment";
      krrss = "kubectl rollout restart statefulset";
      kv = "kubectl version";
      ka = "kubectl apply";
      kaf = "kubectl apply -f";
      kl = "kubectl logs";
      klf = "kubectl logs -f";
      keti = "kubectl exec -it";
      kpf = "kubectl port-forward";

      #kdg = "kubectl debug";
      #kdgti = "kubectl debug -it";
    }

      (kubectl-abbrs "c" "certificate")
      (kubectl-abbrs "cj" "cronjob")
      (kubectl-abbrs "cm" "configmap")
      (kubectl-abbrs "cr" "clusterrole")
      (kubectl-abbrs "crb" "clusterrolebinding")
      (kubectl-abbrs "csec" "clustersecret")
      (kubectl-abbrs "d" "deployment")
      (kubectl-abbrs "ds" "daemonset")
      (kubectl-abbrs "i" "ingress")
      (kubectl-abbrs "ir" "ingressroute")
      (kubectl-abbrs "irt" "ingressroutetcp")
      (kubectl-abbrs "j" "job")
      (kubectl-abbrs "n" "node")
      (kubectl-abbrs "ns" "namespace")
      (kubectl-abbrs "p" "pod")
      (kubectl-abbrs "pv" "pv")
      (kubectl-abbrs "pvc" "pvc")
      (kubectl-abbrs "r" "role")
      (kubectl-abbrs "rb" "rolebinding")
      (kubectl-abbrs "s" "service")
      (kubectl-abbrs "sa" "serviceaccount")
      (kubectl-abbrs "sc" "storageclass")
      (kubectl-abbrs "sec" "secret")
      (kubectl-abbrs "ss" "statefulset")
      (kubectl-abbrs "g" "gateway")

    ];

    shellGlobalAliases = {
      "%%" = "| grep";
      "%y" = "| bat -l yaml";
      "%yq" = "| yq eval";
      "%j" = "| bat -l json";
      "%jq" = "| jq";
      "%xml" = "| xmlstarlet fo | bat --language xml";
      "%x" = "| xmlstarlet fo | bat --language xml";
      "%html" = ''| xmlstarlet fo -H | sed "s/\]\]>//g; s/<!\[CDATA\[//g" |  bat --language html'';
      "%h" = "| xmlstarlet fo -H | bat --language html";
      "%oy" = "-o yaml | bat -l yaml";
      "%doy" = "--dry-run=client -o yaml | bat -l yaml";
      "%oyq" = "-o yaml | yq eval";
      "%oj" = "-o json | bat -l json";
      "%doj" = "--dry-run=client -o json | bat -l json";
      "%ojq" = "-o json | jq";
      "%jwt" = " | jwt decode - | bat --language json";
      "%osks" = " -o yaml | showksec | bat --language yaml";
      "%sks" = " | showksec | bat --language yaml";
      "%l" = " | relog";

      "%b64d" = " | base64 -d";
      "%b64" = " | base64";
      "%b64dx509" = " | base64 -d | openssl x509 -noout -text";
      "%x509" = " | openssl x509 -noout -text";
      "%ocacrt" = ''-o json | jq '.data["ca.crt"]' -r | base64 -d | openssl x509 -noout -text'';
      "%otlscrt" = ''-o json | jq '.data["tls.crt"]' -r | base64 -d | openssl x509 -noout -text'';
    };

    sessionVariables = {
      KUBECOLOR_OBJ_FRESH = "20h";
      PAGER = "less --raw-control-chars --quit-if-one-screen";
      KIND_EXPERIMENTAL_PROVIDER = "podman";

      # goss/dgoss
      CONTAINER_RUNTIME = "podman";

      FORGIT_PAGER = "bat";
      FORGIT_DIFF_PAGER = "delta --line-numbers";
      FORGIT_SHOW_PAGER = "delta --line-numbers";
    };

    antidote = {
      enable = true;
      plugins = [
        "getantidote/use-omz"
        "ohmyzsh/ohmyzsh path:plugins/git"
        "wfxr/forgit kind:defer"
      ];
    };
  };

  programs.carapace = {
    enable = true;
    enableZshIntegration = true;
    package = pkgs-unstable.carapace;
  };

  programs.starship.enable = true;
  programs.starship.enableZshIntegration = true;

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.navi = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.opam = {
    enable = true;
    enableZshIntegration = true;
  };

  services.ssh-agent.enable = true;
  programs.ssh = {
    enable = true;
    addKeysToAgent = "yes";
    includes = [ "custom.conf" ];
  };

  # Seems to be bugged until https://github.com/NixOS/nixpkgs/pull/267878
  # can get merged into unstable
  programs.awscli = {
    enable = true;
    settings = {
      "profile frida-prod" = {
        sso_session = "riskident";
        sso_account_id = 450622064308;
        sso_role_name = "PowerUserAccess";
      };
      "profile frida-prod-admin" = {
        sso_session = "riskident";
        sso_account_id = 450622064308;
        sso_role_name = "AdministratorAccess";
      };

      "profile frida-dev" = {
        sso_session = "riskident";
        sso_account_id = 887791524047;
        sso_role_name = "PowerUserAccess";
      };
      "profile frida-dev-admin" = {
        sso_session = "riskident";
        sso_account_id = 887791524047;
        sso_role_name = "AdministratorAccess";
      };

      "profile platform-playground" = {
        sso_session = "riskident";
        sso_account_id = 128307692781;
        sso_role_name = "PowerUserAccess";
      };
      "profile platform-playground-admin" = {
        sso_session = "riskident";
        sso_account_id = 128307692781;
        sso_role_name = "AdministratorAccess";
      };

      "profile frida-dr" = {
        sso_session = "riskident";
        sso_account_id = 686255960303;
        sso_role_name = "PowerUserAccess";
      };
      "profile frida-dr-admin" = {
        sso_session = "riskident";
        sso_account_id = 686255960303;
        sso_role_name = "AdministratorAccess";
      };

      "profile shared-services" = {
        sso_session = "riskident";
        sso_account_id = 698864150901;
        sso_role_name = "PowerUserAccess";
      };
      "profile shared-services-admin" = {
        sso_session = "riskident";
        sso_account_id = 698864150901;
        sso_role_name = "AdministratorAccess";
      };

      "sso-session riskident" = {
        sso_region = "eu-central-1";
        sso_start_url = "https://d-99676417af.awsapps.com/start/#";
        sso_registration_scopes = "sso:account:access";
      };
    };
  };

  programs.neovim = {
    enable = true;

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
      nvim-treesitter-parsers.elvish
      nvim-treesitter-parsers.fish
      nvim-treesitter-parsers.git_config
      nvim-treesitter-parsers.git_rebase
      nvim-treesitter-parsers.gitattributes
      nvim-treesitter-parsers.gitcommit
      nvim-treesitter-parsers.gitignore
      nvim-treesitter-parsers.gleam
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
      nvim-treesitter-parsers.kdl
      nvim-treesitter-parsers.lua
      nvim-treesitter-parsers.make
      nvim-treesitter-parsers.markdown
      nvim-treesitter-parsers.markdown_inline
      nvim-treesitter-parsers.mermaid
      nvim-treesitter-parsers.nix
      nvim-treesitter-parsers.ocaml
      nvim-treesitter-parsers.org
      nvim-treesitter-parsers.passwd
      nvim-treesitter-parsers.promql
      nvim-treesitter-parsers.python
      nvim-treesitter-parsers.regex
      nvim-treesitter-parsers.requirements
      nvim-treesitter-parsers.rst
      nvim-treesitter-parsers.ruby
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
    source = ../../nvim/init.lua;
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
        "ssh://git@github.2rioffice.com" = {
          insteadOf = "https://github.2rioffice.com";
        };
      };
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
      name = "Adwaita-dark";
      package = pkgs-unstable.gnome-themes-extra;
    };

    cursorTheme = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Ice";
    };

    gtk3 = {
      bookmarks = [
        "file:///home/kallefagerberg/Downloads"
        "file:///home/kallefagerberg/Documents"
        "file:///home/kallefagerberg/Nextcloud"
        "file:///home/kallefagerberg/code"
        "file:///home/kallefagerberg/code/ri"
        "file:///home/kallefagerberg/code/ri/platform"
        "file:///home/kallefagerberg/code/ri/platform/iac"
      ];

      extraConfig = {
        gtk-application-prefer-dark-theme = 1;
      };
    };

    gtk4 = {
      extraConfig = {
        gtk-application-prefer-dark-theme = 1;
      };
    };
  };

  home.sessionVariables = {
    GTK_THEME = "Adwaita-dark";
    PNPM_HOME = "$HOME/.local/share/pnpm";
    EDITOR = "nvim";
    GOPRIVATE = "github.2rioffice.com";
  };

  home.sessionPath = [
    "$HOME/.krew/bin"
    "$HOME/go/bin"
    "$HOME/.local/share/pnpm"
    "$HOME/.local/bin"
  ];

  qt = {
    enable = true;
    platformTheme.name = "kde";
    style = {
      name = "kvantum";
      package = with pkgs; [
        kdePackages.qtstyleplugin-kvantum
        kdePackages.breeze-icons
      ];
    };
  };

  xdg.mimeApps = let
    #browser = "firefox.desktop";
    browser = "zen.desktop";
    email = "thunderbird.desktop";
    editor = "dev.zed.Zed.desktop";
    files = "org.kde.dolphin.desktop";
  in {
    enable = true;
    # Find names of applications installed by Nix in ~/.nix-profile/share/applications
    # Flatpak apps are visible at /var/lib/flatpak/exports/share/applications
    defaultApplications = {
      # Web browser
      "application/pdf" = browser;
      "x-scheme-handler/chrome" = browser;
      "x-scheme-handler/http" = browser;
      "x-scheme-handler/https" = browser;
      "text/html" = browser;
      "application/x-extension-htm" = browser;
      "application/x-extension-html" = browser;
      "application/x-extension-shtml" = browser;
      "application/x-extension-xht" = browser;
      "application/x-extension-xhtml" = browser;
      "application/xhtml+xml" = browser;
      # Email
      "application/x-extension-ics" = email;
      "message/rfc822" = email;
      "text/calendar" = email;
      "x-scheme-handler/mailto" = email;
      "x-scheme-handler/mid" = email;
      "x-scheme-handler/webcal" = email;
      "x-scheme-handler/webcals" = email;
      # Dolphin
      "inode/directory" = files;
      "application/x-directory" = files;

      # Text files
      "application/json" = editor;
      "application/yaml" = editor;
      "text/markdown" = editor;
      "text/x-csrc" = editor;
      "text/plain" = editor;
    };
    associations.added = {
      # Web browser
      "application/x-extension-htm" = browser;
      "application/x-extension-html" = browser;
      "application/x-extension-shtml" = browser;
      "application/x-extension-xht" = browser;
      "application/x-extension-xhtml" = browser;
      "application/xhtml+xml" = browser;
      "text/html" = browser;
      "x-scheme-handler/chrome" = browser;
      "x-scheme-handler/http" = browser;
      "x-scheme-handler/https" = browser;
      # Email
      "x-scheme-handler/mailto" = email;
      "x-scheme-handler/mid" = email;
      "x-scheme-handler/webcal" = email;
      "x-scheme-handler/webcals" = email;
    };
  };

  #xdg.dataFile = let
  #  nodeVersion = "node-v22.5.1-linux-x64";
  #  nodePackage = pkgs.nodejs_22;
  #in {
  #  "zed/node/${nodeVersion}/bin".source = "${nodePackage}/bin";
  #  "zed/node/${nodeVersion}/include".source = "${nodePackage}/include";
  #  "zed/node/${nodeVersion}/lib".source = "${nodePackage}/lib";
  #  "zed/node/${nodeVersion}/share".source = "${nodePackage}/share";
  #};

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "24.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
