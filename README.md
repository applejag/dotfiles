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

sudo ln -vfs `pwd`/wsl/git /usr/local/bin/git
sudo ln -vfs `pwd`/wsl/wsl.conf /etc/wsl.conf

mkdir -pv ~/.config/nvim
ln -vfs `pwd`/nvim/init.vim ~/.config/nvim/init.vim
ln -vfs `pwd`/nvim/coc-settings.json ~/.config/nvim/coc-settings.json

mkdir -pv ~/.config/bat
ln -vfs `pwd`/bat/config ~/.config/bat/config

ln -vfs `pwd`/tmux/.tmux.conf ~/.tmux.conf
mkdir -pv ~/.tmux/plugins
ln -vfs `pwd`/tmux/tpm ~/.tmux/plugins/tpm
ln -vfs `pwd`/tmux/todo.sh ~/.tmux/todo.sh
ln -vfs `pwd`/tmux/kubeconfig.sh ~/.tmux/kubeconfig.sh
sudo ln -vfs `pwd`/tmux/tmux-first-unattached-session /usr/local/bin/,tmux-first-unattached-session

git clone --recurse-submodules --remote-submodules --depth 1 -j 2 https://github.com/lcpz/awesome-copycats.git ~/.config/awesome
ln -vfs `pwd`/awesome ~/.config/awesome

ln -vfs `pwd`/alacritty/alacritty.yml ~/.config/alacritty/alacritty.yml

ln -vfs `pwd`/picom/picom.conf ~/.config/picom.conf

ln -vfs `pwd`/X11/.Xmodmap ~/.Xmodmap
ln -vfs `pwd`/X11/.xinitrc ~/.xinitrc

mkdir -pv ~/dev
ln -vfs `pwd`/scripts ~/dev/scripts

QUTEBROWSER_CONF=~/.config # default
QUTEBROWSER_CONF=~/.var/app/org.qutebrowser.qutebrowser/config/qutebrowser # flatpak

mkdir -pv $QUTEBROWSER_CONF
ln -vfs `pwd`/qutebrowser/config.py $QUTEBROWSER_CONF/base_config.py # default
cp -v `pwd`/qutebrowser/config.py $QUTEBROWSER_CONF/base_config.py # flatpak

mkdir -pv ~/.local/share/timetrap
ln -vfs `pwd`/timetrap/.timetrap.yml ~/.timetrap.yml
git clone git://github.com/samg/timetrap_formatters ~/.local/share/timetrap/timetrap_formatters

ln -vfs `pwd`/qutebrowser/zifro_config.py $QUTEBROWSER_CONF/config.py
```

