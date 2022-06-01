# Dotfiles of jilleJr

> ⚠️ Remember to make backups of your existing dotfiles!
>
> These scripts overrides your existing dotfiles

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

mkdir -pv ~/.config
git clone --recurse-submodules --remote-submodules --depth 1 -j 2 https://github.com/lcpz/awesome-copycats.git ~/.config/awesome
ln -vfs `pwd`/awesome/rc.lua ~/.config/awesome/rc.lua

ln -vfs `pwd`/alacritty/alacritty.yml ~/.config/alacritty/alacritty.yml

ln -vfs `pwd`/picom/picom.conf ~/.config/picom.conf

ln -vfs `pwd`/X11/.Xmodmap ~/.Xmodmap
ln -vfs `pwd`/X11/.xinitrc ~/.xinitrc

mkdir -pv ~/dev
ln -vfs `pwd`/scripts ~/dev/scripts
```

