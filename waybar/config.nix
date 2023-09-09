{
  mainBar = {
    layer = "top"; # Waybar at top layer
    # position = "bottom"; # Waybar position (top|bottom|left|right)
    height = 48; # Waybar height (to be removed for auto height)
    # width = 1280; # Waybar width
    spacing = 4; # Gaps between modules (4px)
    # Choose the order of the modules
    modules-left = ["hyprland/workspaces" "custom/dinkur" "hyprland/window"];
    modules-center = [];
    modules-right = ["tray" "idle_inhibitor" "pulseaudio" "network" "cpu" "backlight" "battery" "clock"];
    # Modules configuration
    "hyprland/workspaces" = {
      #persistent_workspaces = {
      #  "* = 7
      #};
  	active-only = true;
    };
    "river/tags" = {
      num-tags = 9;
    };
    "river/window" = {
      max-length = 48;
    };
    "custom/dinkur" = {
      exec = "~/go/bin/dinkur-statusline --color pango";
      interval = 1;
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
      tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
      locale = "";
      format = "{:%Y-%m-%d %H:%M}";
      format-alt = "{:%H:%M}";
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
      format = "{volume}% {icon} {format_source}";
      format-bluetooth = "{volume}% {icon} {format_source}";
      format-bluetooth-muted = "🔇 {icon} {format_source}";
      format-muted = "🔇 {format_source}";
      format-source = "{volume}% ";
      format-source-muted = "";
      format-icons = {
        headphone = "";
        hands-free = "";
        headset = "";
        phone = "";
        portable = "";
        car = "";
        default = ["" "" ""];
      };
      on-click = "pwvucontrol";
    };
  };
}
