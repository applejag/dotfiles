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
	swaybg \
	swaylock \
	waybar \
	playerctl
```

### ybacklight

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

## Building

```sh
git clone git@github.com:riverwm/river.git --recursive ~/code/river

cd ~/code/river

sudo zig build -Drelease-safe -Dxwayland --prefix /usr/local install

mkdir -pv ~/.config/river
ln -vfs ~/dotfiles/river ~/.config/river
```
