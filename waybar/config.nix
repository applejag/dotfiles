{
  mainBar = {
    layer = "top"; # top | bottom
    # position = "bottom"; # Waybar position (top|bottom|left|right)
    # Choose the order of the modules
    modules-left = [
      "image#nix-snowflake"
      "niri/workspaces"
      "custom/dinkur"
      "custom/next-meeting"
      #"niri/window"
    ];
    modules-center = [];
    modules-right = [
      #"custom/prs-github-com"
      "custom/prs-internal"
      "tray"
      "custom/notification"
      "pulseaudio"
      #"network"
      "cpu"
      "backlight"
      "battery"
      "idle_inhibitor"
      "clock"
    ];
    "image#nix-snowflake" = {
      path = ../waybar/nix-snowflake.png;
      on-click = "wlogout";
      size = 24;
    };
    # Niri
    "niri/workspaces" = {
      format = "{icon} {name}";
      format-icons = {
        active = "";
        default = "";
      };
    };
    "niri/window" = {
      format = "{title}";
      separate-outputs = true;
      icon = true;
    };
    # Hyprland
    "hyprland/workspaces" = {
      format = "{icon} {windows}";
      window-rewrite-default = "";
      # Map window classes to icons
      # Find icons here: https://www.nerdfonts.com/cheat-sheet
      window-rewrite = {
        firefox = "";
        alacritty = "";
        code = "󰨞";
        slack = "󰒱";
        thunderbird = "";
        "1Password" = "";
        rofi = "";
        Chromium-browser = "";
        "chrome-.*" = "";
        Spotify = "󰓇";
        "org.kde.elisa" = "󰧔";
        emacs = "";
        steam = "󰓓";
        "dev.zed.Zed" = "";
        Godot_Engine = "";
        audacity = "";
        "org.kde.dolphin" = "";
      };
    };
    # River
    "river/tags" = {
      num-tags = 9;
    };
    "river/window" = {
      max-length = 48;
    };
    "custom/dinkur" = {
      exec = "dinkur-statusline --color pango";
      interval = 1;
    };
    "custom/next-meeting" = {
      exec = "next-meeting --notify 1m";
      interval = 5;
    };
    "custom/prs-internal" = {
      exec = "${../scripts/gh-pending-prs.sh} github.2rioffice.com 󰦝";
      restart-interval = 300;
      on-click = "xdg-open 'https://github.2rioffice.com/pulls'";
    };
    "custom/prs-github-com" = {
      exec = "${../scripts/gh-pending-prs.sh} github.com  --owner=RiskIdent";
      restart-interval = 300;
      on-click = "xdg-open 'https://github.com/pulls?q=is%3Aopen+is%3Apr+author%3Aapplejag+archived%3Afalse+owner%3ARiskIdent'";
    };
    mpd = {
      format = "{stateIcon} {consumeIcon}{randomIcon}{repeatIcon}{singleIcon}{artist} - {title} {volume}% ";
      format-disconnected = "Disconnected ";
      format-stopped = "{consumeIcon}{randomIcon}{repeatIcon}{singleIcon}Stopped ";
      unknown-tag = "N/A";
      interval = 2;
      consume-icons = {
        on = " ";
      };
      random-icons = {
        off = "<span color=\"#c24848\"></span> ";
        on = " ";
      };
      repeat-icons = {
        on = " ";
      };
      single-icons = {
        on = "1 ";
      };
      state-icons = {
        paused = "";
        playing = "";
      };
      tooltip-format = "MPD (connected)";
      tooltip-format-disconnected = "MPD (disconnected)";
      title-len = 32;
    };
    "custom/notification" = {
      tooltip = false;
      format = "{icon}";
      format-icons = {
        notification = "<span foreground='red'><sup></sup></span>";
        none = "";
        dnd-notification = "<span foreground='red'><sup></sup></span>";
        dnd-none = "";
        inhibited-notification = "<span foreground='red'><sup></sup></span>";
        inhibited-none = "";
        dnd-inhibited-notification = "<span foreground='red'><sup></sup></span>";
        dnd-inhibited-none = "";
      };
      return-type = "json";
      exec-if = "which swaync-client";
      exec = "swaync-client -swb";
      on-click = "swaync-client -t -sw";
      on-click-right = "swaync-client -d -sw";
      escape = true;
    };
    idle_inhibitor = {
      format = "{icon}";
      format-icons = {
        activated = "";
        deactivated = "";
      };
    };
    clock = {
      # timezone = "America/New_York";
      today-format = "<span color='#ff6699'><b>{}</b></span>";
      tooltip-format = "<tt><small>{calendar}</small></tt>";
      locale = "";
      format = "{:%Y-%m-%d %H:%M}";
      format-alt = "{:%H:%M}";
      calendar= {
        mode         = "year";
        mode-mon-col = 3;
        weeks-pos    = "right";
        on-scroll    = 1;
        format= {
          months =   "<span color='#eed49f'><b>{}</b></span>";
          days =     "<span color='#b8c0e0'>{}</span>";
          weeks =    "<span color='#c6a0f6'><b>W{}</b></span>";
          weekdays = "<span color='#f5a97f'><b>{}</b></span>";
          today =    "<span color='#ed8796'><b>{}</b></span>";
        };
      };
      actions = {
        on-click-right = "mode";
        on-scroll-up = "shift_up";
        on-scroll-down = "shift_down";
      };
    };
    tray = {
      icon-size = 21;
      spacing = 10;
    };
    cpu = {
      interval = 2;
      #format = "{usage}% ";
      format = "{icon0}{icon1}{icon2}{icon3}{icon4}{icon5}{icon6}{icon7}";
      format-icons = ["▁" "▂" "▃" "▄" "▅" "<span color=\"#e6e600\">▆</span>" "<span color=\"#f1c40f\">▇</span>" "<span color=\"#f53c3c\">█</span>"];
      tooltip = false;
    };
    memory = {
      interval = 10;
      format = "{}% ";
    };
    backlight = {
      device = "intel_backlight";
      format = "{percent}% {icon}";
      format-icons = ["" "" "" "" "" "" "" "" ""];
      #on-scroll-up = "ybacklight -inc 5";
      #on-scroll-down = "ybacklight -dec 5";
      smooth-scrolling-threshold = 0.9;
    };
    battery = {
      states = {
        # good = 95;
        warning = 30;
        critical = 15;
      };
      format = "{capacity}% {icon}";
      format-charging = "{capacity}% ";
      format-plugged = "{capacity}% ";
      format-alt = "{time} {icon}";
      # format-good = ""; # An empty format will hide the module
      # format-full = "";
      format-icons = ["" "" "" "" ""];
    };
    network = {
      # interface = "wlp2*"; # (Optional) To force the use of this interface
      format-wifi = "{essid} ({signalStrength}%) ";
      format-ethernet = "{ipaddr}/{cidr} ";
      tooltip-format = "{ifname} via {gwaddr} ";
      format-linked = "{ifname} (No IP) ";
      format-disconnected = "Disconnected ⚠";
      format-alt = "{ifname}: {ipaddr}/{cidr}";
    };
    pulseaudio = {
      # scroll-step = 1; # %, can be a float
      format = "{icon} {volume}%";
      format-bluetooth = "{icon} {volume}%";
      format-bluetooth-muted = "🔇 {volume}%";
      format-muted = "🔇 {volume}%";
      format-icons = {
        default = ["" "" ""];
      };
      on-click = "pwvucontrol";
      #on-click = "pavucontrol";
    };
  };
}
