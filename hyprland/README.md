# Hyprland

Find latest release: <https://github.com/hyprwm/Hyprland/releases>

```sh
rm -rfv ~/code/hyprland
VERSION=v0.19.0beta
wget -O- https://github.com/hyprwm/Hyprland/releases/download/$VERSION/$VERSION.tar.gz | tar -xzC ~/code

cd ~/code/hyprland
sudo cp -v Hyprland hyprctl /usr/local/bin/
sudo cp -v libwlroots.so.* /usr/local/lib/
sudo cp -v example/hyprland.desktop /usr/local/share/wayland-sessions

ln -vfs ~/dotfiles/hyprland ~/.config/hypr
```

Add `/usr/local/lib` to known library dirs:

```sh
echo /usr/local/lib | sudo tee /etc/ld.so.conf.d/usr-local-lib.conf
sudo ldconfig
```

## libxcb-errors

```sh
sudo dnf install autoconf xcb-proto xorg-x11-util-macros automake libxcb-devel
git clone https://gitlab.freedesktop.org/xorg/lib/libxcb-errors --recursive ~/code/libxcb-errors
cd ~/code/libxcb-errors
./autogen.sh --prefix=/usr
sudo make install
```
