# Dotfiles of jilleJr

## Make links to dotfiles, Linux

```sh
ln -vfs `pwd`/zsh/.zprofile ~/.zprofile
ln -vfs `pwd`/zsh/.zshenv ~/.zshenv
ln -vfs `pwd`/zi/.zshrc ~/.zshrc

mkdir -pv ~/.config/gh
ln -vfs `pwd`/gh/config.yml ~/.config/gh/config.yml

mkdir -pv ~/.config/nvim
ln -vfs `pwd`/nvim/init.vim ~/.config/nvim/init.vim
ln -vfs `pwd`/nvim/coc-settings.json ~/.config/nvim/coc-settings.json

mkdir -pv ~/.config/bat
ln -vfs `pwd`/bat/config ~/.config/bat/config

ln -vfs `pwd`/awesome ~/.config/awesome

mkdir -pv ~/.config/alacritty
ln -vfs `pwd`/alacritty/alacritty.yml ~/.config/alacritty/alacritty.yml

ln -vfs `pwd`/picom/picom.conf ~/.config/picom.conf

ln -vfs `pwd`/starship/starship.toml ~/.config/starship.toml

mkdir -pv ~/.config/mpd
ln -vfs `pwd`/mpd/mpd.conf ~/.config/mpd/mpd.conf

ln -vfs `pwd`/X11/.Xmodmap ~/.Xmodmap
ln -vfs `pwd`/X11/.xinitrc ~/.xinitrc

mkdir -pv ~/.config/waybar
ln -vfs `pwd`/waybar/config ~/.config/waybar/config

mkdir -pv ~/dev
ln -vfs `pwd`/scripts ~/dev/scripts
```
