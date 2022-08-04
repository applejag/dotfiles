# Dotfiles of jilleJr

## Make links to dotfiles, Linux

```sh
ln -vfs ~/dotfiles/zsh/.zprofile ~/.zprofile
ln -vfs ~/dotfiles/zsh/.zshenv ~/.zshenv
ln -vfs ~/dotfiles/zi/.zshrc ~/.zshrc

mkdir -pv ~/.config/gh
ln -vfs ~/dotfiles/gh/config.yml ~/.config/gh/config.yml

mkdir -pv ~/.config/nvim
ln -vfs ~/dotfiles/nvim/init.vim ~/.config/nvim/init.vim
ln -vfs ~/dotfiles/nvim/coc-settings.json ~/.config/nvim/coc-settings.json

mkdir -pv ~/.config/bat
ln -vfs ~/dotfiles/bat/config ~/.config/bat/config

ln -vfs ~/dotfiles/awesome ~/.config/awesome

mkdir -pv ~/.config/alacritty
ln -vfs ~/dotfiles/alacritty/alacritty.yml ~/.config/alacritty/alacritty.yml

ln -vfs ~/dotfiles/picom/picom.conf ~/.config/picom.conf

ln -vfs ~/dotfiles/starship/starship.toml ~/.config/starship.toml

mkdir -pv ~/.config/mpd
ln -vfs ~/dotfiles/mpd/mpd.conf ~/.config/mpd/mpd.conf

ln -vfs ~/dotfiles/X11/.Xmodmap ~/.Xmodmap
ln -vfs ~/dotfiles/X11/.xinitrc ~/.xinitrc

ln -vfs ~/dotfiles/waybar ~/.config/waybar

ln -vfs ~/dotfiles/swaylock ~/.config/swaylock

mkdir -pv ~/dev
ln -vfs ~/dotfiles/scripts ~/dev/scripts
```

## ybacklight

```sh
sudo curl -o /usr/local/bin/ybacklight "https://github.com/yath/ybacklight/raw/ac3067350618bd9f95bb8fac678e6bdfff74a7e0/ybacklight"
sudo chmod +x /usr/local/bin/ybacklight

sudo groupadd backlighters
sudo usermod --append --groups backlighters `whoami`
for attr in brightness max_brightness; do
	sudo chgrp -R backlighters /sys/class/backlight/*/$attr
	sudo chmod g+w /sys/class/backlight/*/$attr
done
```
