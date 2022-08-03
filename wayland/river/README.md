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

## Building

```sh
git clone git@github.com:riverwm/river.git --recursive ~/code/river

cd ~/code/river

sudo zig build -Drelease-safe -Dxwayland --prefix /usr/local install

mkdir -pv ~/.config/river
ln -vfs ~/dotfiles/wayland/river/init ~/.config/river/init
```
