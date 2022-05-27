# Dotfiles of jilleJr

> ⚠️ Remember to make backups of your existing dotfiles!
>
> These scripts overrides your existing dotfiles

## Make links to dotfiles, Linux

```sh
ln -vfs `pwd`/zsh/.zprofile ~/.zprofile_base.zsh
ln -vfs `pwd`/zsh/.zshenv ~/.zshenv
ln -vfs `pwd`/zi/.zshrc ~/.zshrc
ln -vfs `pwd`/zsh/.p10k.zsh ~/.p10k.zsh

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

mkdir -pv ~/.config/awesome
ln -vfs `pwd`/awesomewm/autorun.sh ~/.config/awesome/autorun.sh
ln -vfs `pwd`/awesomewm/rc.lua ~/.config/awesome/rc.lua

ln -vfs `pwd`/alacritty/alacritty-zifro.yml ~/.config/alacritty/alacritty.yml

ln -vfs `pwd`/X11/.Xmodmap ~/.Xmodmap
ln -vfs `pwd`/X11/.xinitrc ~/.xinitrc

mkdir -pv ~/dev
ln -vfs `pwd`/scripts ~/dev/scripts

mv -f ~/.doom.d ~/.doom.d.old
ln -vfs `pwd`/doom ~/.doom.d

QUTEBROWSER_CONF=~/.config # default
QUTEBROWSER_CONF=~/.var/app/org.qutebrowser.qutebrowser/config/qutebrowser # flatpak

mkdir -pv $QUTEBROWSER_CONF
ln -vfs `pwd`/qutebrowser/config.py $QUTEBROWSER_CONF/base_config.py # default
cp -v `pwd`/qutebrowser/config.py $QUTEBROWSER_CONF/base_config.py # flatpak

mkdir -pv ~/.local/share/timetrap
ln -vfs `pwd`/timetrap/.timetrap.yml ~/.timetrap.yml
git clone git://github.com/samg/timetrap_formatters ~/.local/share/timetrap/timetrap_formatters

mkdir -pv ~/.config/picom
ln -vfs `pwd`/picom/picom.conf ~/.config/picom/picom.conf

# Zifro laptop
ln -vfs `pwd`/zsh/zifro.zprofile ~/.zprofile

ln -vfs `pwd`/qutebrowser/zifro_config.py $QUTEBROWSER_CONF/config.py

# Iver laptop
ln -vfs `pwd`/zsh/iver.zprofile ~/.zprofile
ln -vfs `pwd`/nvim/iver_init.vim ~/.config/nvim/local.vim

ln -vfs `pwd`/git/iver.gitconfig ~/.gitconfig

ln -vfs `pwd`/qutebrowser/iver_config.py $QUTEBROWSER_CONF/config.py # flatpak
cp -v `pwd`/qutebrowser/iver_config.py $QUTEBROWSER_CONF/config.py # flatpak
```

## Make links to dotfiles, Windows

```powershell
# Run as administrator
New-Item  -Force -ItemType SymbolicLink -Path "$env:AppData\alacritty\alacritty.yml" -Target ".\alacritty\alacritty-iver.yml"
New-Item  -Force -ItemType SymbolicLink -Path "$env:AppData\bug.n\Config.ini" -Target ".\bug.n\Config.ini"
New-Item  -Force -ItemType SymbolicLink -Path "$env:AppData\qutebrowser\config\config.py" -Target ".\qutebrowser\config.py"
New-Item  -Force -ItemType SymbolicLink -Path "$env:AppData\qutebrowser\config\base_config.py" -Target ".\qutebrowser\config.py"

$wt = Get-Item "$env:LocalAppData\Packages\Microsoft.WindowsTerminal_*"
New-Item  -Force -ItemType SymbolicLink -Path "$wt\LocalState\settings.json" -Target ".\wt\settings.json"

# Zifro laptop
New-Item  -Force -ItemType SymbolicLink -Path "$env:AppData\qutebrowser\config\config.py" -Target ".\qutebrowser\zifro_config.py"

# Iver laptop
New-Item  -Force -ItemType SymbolicLink -Path "$env:AppData\qutebrowser\config\config.py" -Target ".\qutebrowser\iver_config.py"
```
