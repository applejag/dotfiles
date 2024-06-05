# Dotfiles of jilleJr

## Make links to dotfiles, Linux

```sh
ln -vfs ~/dotfiles/zsh/.zprofile ~/.zprofile
ln -vfs ~/dotfiles/zsh/.zshenv ~/.zshenv
ln -vfs ~/dotfiles/zi/.zshrc ~/.zshrc

ln -vfs ~/{dotfiles,.config}/elvish

mkdir -pv ~/.config/carapace
ln -vfs ~/{dotfiles,.config}/carapace/specs
ln -vfs ~/{dotfiles,.config}/carapace/bridges.yaml

ln -vfs ~/{dotfiles,.config}/hypr

ln -vfs ~/{dotfiles,.config}/home-manager

mkdir -pv ~/.config/gh
ln -vfs ~/{dotfiles,.config}/gh/config.yml

mkdir -pv ~/.config/nvim
ln -vfs ~/{dotfiles,.config}/nvim/init.vim
ln -vfs ~/{dotfiles,.config}/nvim/after
ln -vfs ~/{dotfiles,.config}/nvim/coc-settings.json

mkdir -pv ~/.config/bat
ln -vfs ~/{dotfiles,.config}/bat/config

ln -vfs ~/{dotfiles,.config}/awesome

mkdir -pv ~/.config
ln -vfs ~/{dotfiles,.config}/alacritty

ln -vfs ~/{dotfiles/picom,.config}/picom.conf

ln -vfs ~/{dotfiles/starship,.config}/starship.toml

mkdir -pv ~/.config/mpd
ln -vfs ~/{dotfiles,.config}/mpd/mpd.conf

ln -vfs ~/dotfiles/X11/.Xmodmap ~/.Xmodmap
ln -vfs ~/dotfiles/X11/.xinitrc ~/.xinitrc

ln -vfs ~/{dotfiles,.config}/waybar

ln -vfs ~/{dotfiles,.config}/swaylock

ln -vfs ~/{dotfiles,.config}/swaync

ln -vfs ~/{dotfiles,.config}/fnott

ln -vfs ~/{dotfiles,.config}/mpDris2

ln -vfs ~/{dotfiles,.config}/way-displays

# tmux
ln -vfs ~/dotfiles/tmux/.tmux.conf ~/.tmux.conf
mkdir -pv ~/.tmux/plugins
ln -vfs ~/dotfiles/tmux/tpm ~/.tmux/plugins/tpm
ln -vfs ~/dotfiles/tmux/kubeconfig.sh ~/.tmux/kubeconfig.sh
```

