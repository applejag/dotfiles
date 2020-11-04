# Dotfiles of jilleJr

> ⚠️ Remember to make backups of your existing dotfiles!
>
> These scripts overrides your existing dotfiles

## Make links to dotfiles, Linux

```sh
ln -vfs `pwd`/zsh/.zprofile ~/.zprofile_base
ln -vfs `pwd`/zsh/.zshenv ~/.zshenv
ln -vfs `pwd`/zinit/.zshrc ~/.zshrc
ln -vfs `pwd`/zsh/.p10k.zsh ~/.p10k.zsh
sudo ln -vfs `pwd`/wsl/git /usr/local/bin/git
mkdir -pv ~/.config/nvim
ln -vfs `pwd`/nvim/init.vim ~/.config/nvim/init.vim
mkdir -pv ~/.config/bat
ln -vfs `pwd`/bat/config ~/.config/bat/config
ln -vfs `pwd`/tmux/.tmux.conf ~/.tmux.conf
mkdir -pv ~/.tmux/plugins
ln -vfs `pwd`/tmux/tpm ~/.tmux/plugins/tpm
ln -vfs `pwd`/tmux/todo.sh ~/.tmux/todo.sh
ln -vfs `pwd`/tmux/kubeconfig.sh ~/.tmux/kubeconfig.sh
sudo ln -vfs `pwd`/tmux/tmux-first-unattached-session /usr/local/bin/,tmux-first-unattached-session
mkdir -pv ~/dev
ln -vfs `pwd`/scripts ~/dev/scripts
mkdir -pv ~/.doom.d
ln -vfs `pwd`/doom/config.el ~/.doom.d/config.el
ln -vfs `pwd`/doom/packages.el ~/.doom.d/packages.el
ln -vfs `pwd`/doom/init.el ~/.doom.d/init.el

# Zifro laptop
ln -vfs `pwd`/zsh/zifro.zprofile ~/.zprofile

# Iver laptop
ln -vfs `pwd`/zsh/iver.zprofile ~/.zprofile
ln -vfs `pwd`/nvim/iver_init.vim ~/.config/nvim/local.vim
```

## Make links to dotfiles, Windows

```powershell
# Run as administrator
New-Item  -Force -ItemType SymbolicLink -Path "$env:AppData\alacritty\alacritty.yml" -Target ".\alacritty\alacritty.yml"
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
