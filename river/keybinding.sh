#!/bin/sh

riverctl map normal Control+Alt L spawn swaylock

riverctl map normal Super P spawn wofi

riverctl map normal Super Return spawn alacritty

riverctl map normal Control Space spawn 'fnottctl dismiss'
riverctl map normal Super BackSpace spawn 'fnottctl actions'

# Screenshot region, saves at ~/Pictures/Screenshots/wayshot_YYYY-mm-dd_HH-MM-SS.png
# and copies to clipboard
riverctl map normal None Print spawn "wayshot -s \"\$(slurp -f '%x %y %w %h')\" --stdout | tee ~/Pictures/Screenshots/\$(date +wayshot_%F_%H.%M.%S.png) | wl-copy"
# Screenshot full screen, saves at ~/Pictures/Screenshots/wayshot_YYYY-mm-dd_HH-MM-SS.png
# and copies to clipboard
riverctl map normal Super Print spawn "wayshot --stdout | tee ~/Pictures/Screenshots/\$(date +wayshot_%F_%H.%M.%S.png) | wl-copy"
# Color-pick a pixel on screen and copy to clipboard, format #RRGGBB
riverctl map normal Super+Control C spawn "wayshot -s \"\$(slurp -p -f '%x %y %w %h')\" --stdout | convert - -format '%[pixel:p{0,0}]' txt:-|egrep \"#([A-Fa-f0-9]{6}|[A-Fa-f0-9]{3})\" -o|tr -d '\\n'|wl-copy"

# Super+Q & Super+Shift+C to close the focused view
riverctl map normal Super Q close
riverctl map normal Super+Shift C close

# Super+Shift+E to exit river
riverctl map normal Super+Shift E exit

# Super+J and Super+K to focus the next/previous view in the layout stack
riverctl map normal Super J focus-view next
riverctl map normal Super K focus-view previous

# Super+Shift+J and Super+Shift+K to swap the focused view with the next/previous
# view in the layout stack
riverctl map normal Super+Shift J swap next
riverctl map normal Super+Shift K swap previous

# Super+Period and Super+Comma to focus the next/previous output
riverctl map normal Super Period focus-output next
riverctl map normal Super Comma focus-output previous

# Super+Shift+{Period,Comma} to send the focused view to the next/previous output
riverctl map normal Super+Shift Period send-to-output next
riverctl map normal Super+Shift Comma send-to-output previous

# Super+H and Super+L to decrease/increase the main ratio of rivertile(1)
riverctl map normal Super H send-layout-cmd rivertile "main-ratio -0.05"
riverctl map normal Super L send-layout-cmd rivertile "main-ratio +0.05"

# Super+Shift+H and Super+Shift+L to increment/decrement the main count of rivertile(1)
riverctl map normal Super+Shift H send-layout-cmd rivertile "main-count +1"
riverctl map normal Super+Shift L send-layout-cmd rivertile "main-count -1"

# Super+Alt+{H,J,K,L} to move views
riverctl map normal Super+Alt H move left 100
riverctl map normal Super+Alt J move down 100
riverctl map normal Super+Alt K move up 100
riverctl map normal Super+Alt L move right 100

# Super+Alt+Control+{H,J,K,L} to snap views to screen edges
riverctl map normal Super+Alt+Control H snap left
riverctl map normal Super+Alt+Control J snap down
riverctl map normal Super+Alt+Control K snap up
riverctl map normal Super+Alt+Control L snap right

# Super+Alt+Shift+{H,J,K,L} to resize views
riverctl map normal Super+Alt+Shift H resize horizontal -100
riverctl map normal Super+Alt+Shift J resize vertical 100
riverctl map normal Super+Alt+Shift K resize vertical -100
riverctl map normal Super+Alt+Shift L resize horizontal 100

# Super + Left Mouse Button to move views
riverctl map-pointer normal Super BTN_LEFT move-view

# Super + Right Mouse Button to resize views
riverctl map-pointer normal Super BTN_RIGHT resize-view

for i in $(seq 1 9)
do
    tags=$((1 << ($i - 1)))

    # Super+[1-9] to focus tag [0-8]
    riverctl map normal Super $i set-focused-tags $tags

    # Super+Shift+[1-9] to tag focused view with tag [0-8]
    riverctl map normal Super+Shift $i set-view-tags $tags

    # Super+Ctrl+[1-9] to toggle focus of tag [0-8]
    riverctl map normal Super+Control $i toggle-focused-tags $tags

    # Super+Shift+Ctrl+[1-9] to toggle tag [0-8] of focused view
    riverctl map normal Super+Shift+Control $i toggle-view-tags $tags
done

# Super+0 to focus all tags
# Super+Shift+0 to tag focused view with all tags
all_tags=$(((1 << 32) - 1))
riverctl map normal Super 0 set-focused-tags $all_tags
riverctl map normal Super+Shift 0 set-view-tags $all_tags

# Super+Space to toggle float
riverctl map normal Super Space toggle-float

# Super+M to toggle maximize
riverctl map normal Super M toggle-fullscreen

# Super+{Up,Right,Down,Left} to change layout orientation
riverctl map normal Super Up    send-layout-cmd rivertile "main-location top"
riverctl map normal Super Right send-layout-cmd rivertile "main-location right"
riverctl map normal Super Down  send-layout-cmd rivertile "main-location bottom"
riverctl map normal Super Left  send-layout-cmd rivertile "main-location left"

# Declare a passthrough mode. This mode has only a single mapping to return to
# normal mode. This makes it useful for testing a nested wayland compositor
riverctl declare-mode passthrough

# Super+F11 to enter passthrough mode
riverctl map normal Super F11 enter-mode passthrough

# Super+F11 to return to normal mode
riverctl map passthrough Super F11 enter-mode normal

# Various media key mapping examples for both normal and locked mode which do
# not have a modifier
for mode in normal locked
do
    # Eject the optical drive (well if you still have one that is)
    riverctl map $mode None XF86Eject spawn 'eject -T'

    # Control pulse audio volume with pamixer (https://github.com/cdemoulins/pamixer)
    riverctl map $mode None XF86AudioRaiseVolume  spawn "$HOME/dotfiles/scripts/pactl-set-volume.sh 5"
    riverctl map $mode None XF86AudioLowerVolume  spawn "$HOME/dotfiles/scripts/pactl-set-volume.sh -5"
    riverctl map $mode None XF86AudioMute         spawn 'pactl set-sink-mute @DEFAULT_SINK@ toggle'

    # Control MPRIS aware media players with playerctl (https://github.com/altdesktop/playerctl)
    riverctl map $mode None XF86AudioMedia spawn 'playerctl play-pause'
    riverctl map $mode None XF86AudioPlay  spawn 'playerctl play-pause'
    riverctl map $mode None XF86AudioPrev  spawn 'playerctl previous'
    riverctl map $mode None XF86AudioNext  spawn 'playerctl next'

    # Control screen backlight brightness with light (https://github.com/haikarainen/light)
    riverctl map $mode None XF86MonBrightnessUp   spawn 'ybacklight -inc 10'
    riverctl map $mode None XF86MonBrightnessDown spawn 'ybacklight -dec 10'
done

# Set keyboard repeat rate
riverctl set-repeat 50 300

