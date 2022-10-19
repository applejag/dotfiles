# Hyprland

Find latest release: <https://github.com/hyprwm/Hyprland/releases>

```sh
rm -rfv ~/code/hyprland
VERSION=v0.16.0beta
wget -O- https://github.com/hyprwm/Hyprland/releases/download/$VERSION/$VERSION.tar.gz | tar -xzC ~/code

cd ~/code/hyprland
sudo cp -v Hyprland hyprctl /usr/local/bin/
sudo cp -v libwlroots.so.* /usr/local/lib/
sudo cp -v example/hyprland.desktop /usr/local/share/wayland-sessions

ln -vfs ~/dotfiles/hyprland ~/.config/hypr
```
