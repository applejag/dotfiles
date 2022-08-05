# River (Window Manager)

## Dependencies

Fedora:

```sh
sudo dnf install \
	libevdev-devel \
	libxkbcommon-devel \
	pixman-devel \
	pkgconf-pkg-config \
	scdoc \
	wayland-devel \
	wayland-protocols-devel \
	wlroots-devel \
	zig
```

## Tools

### Fedora

```sh
sudo dnf install \
	mpdris2 \
	playerctl \
	slurp \
	swaybg \
	swayidle \
	swaylock \
	waybar \
	wl-clipboard \
	xdg-desktop-portal-wlr
```

### ybacklight

Lightweight Perl script to change screen backlight.
<https://github.com/yath/ybacklight>

```sh
sudo curl -o /usr/local/bin/ybacklight "https://github.com/yath/ybacklight/raw/ac3067350618bd9f95bb8fac678e6bdfff74a7e0/ybacklight"
sudo chmod +x /usr/local/bin/ybacklight

sudo groupadd backlighters
sudo usermod --append --groups backlighters $(whoami)
for attr in brightness max_brightness; do
	sudo chgrp -R backlighters /sys/class/backlight/*/$attr
	sudo chmod g+w /sys/class/backlight/*/$attr
done
```

### wlopm

Controls zwlr-output-power-management-v1 Wayland protocol. Allows turning
on/off monitors (DPMS, Display Power Management Signaling).
<https://sr.ht/~leon_plickat/wlopm>

```sh
git clone https://git.sr.ht/~leon_plickat/wlopm ~/code/wlopm

cd ~/code/wlopm

make
sudo make install
```

### wayshot

Screenshotting tool. <https://github.com/waycrate/wayshot>
My usage requires `slurp`: <https://github.com/emersion/slurp>

```sh
git clone https://github.com/waycrate/wayshot ~/code/wayshot
cd ~/code/wayshot
make setup
make
sed -i '
	s|^TARGET_DIR := .*|TARGET_DIR := /usr/local/bin|
	s|^MAN\([0-9]\)_DIR := .*|MAN\1_DIR := /usr/local/share/man/man\1|
	s|^install:.*|install:|
' Makefile
sudo make install
```

### fnott

```sh
sudo dnf install tllist-devel meson ninja-build
git clone https://codeberg.org/dnkl/fnott.git ~/code/fnott
cd ~/code/fnott
mkdir -pv bld/release && cd bld/release
meson --buildtype=release ../..
ninja
sudo ninja install
```

### mpDris2

```sh
sudo dnf install intltool
git clone https://github.com/eonpatapon/mpDris2.git ~/code/mpDris2
cd ~/code/mpDris2
./autogen.sh --sysconfdir=/etc
sudo make install
```

### way-displays

```sh
sudo dnf install yaml-cpp-devel
git clone git@github.com:alex-courtis/way-displays.git ~/code/way-displays
cd ~/code/way-displays
make
sudo make install
```

## Building

```sh
git clone git@github.com:riverwm/river.git --recursive ~/code/river

cd ~/code/river

sudo zig build -Drelease-safe -Dxwayland --prefix /usr/local install

mkdir -pv ~/.config/river
ln -vfs ~/dotfiles/river ~/.config/river

sudo mkdir -pv /usr/local/share/wayland-sessions
sudo cp -v ~/dotfiles/river/river.desktop /usr/local/share/wayland-sessions/river.desktop
```
