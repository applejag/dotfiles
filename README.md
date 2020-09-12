# Dotfiles of jilleJr

> ⚠️ Remember to make backups of your existing dotfiles!
>
> These scripts overrides your existing dotfiles

## Make links to dotfiles, Linux

```sh
ln -vfs `pwd`/zsh/.zprofile ~/.zprofile
ln -vfs `pwd`/zsh/.zshenv ~/.zshenv
ln -vfs `pwd`/zinit/.zshrc ~/.zshrc
ln -vfs `pwd`/zsh/.p10k.zsh ~/.p10k.zsh
sudo ln -vfs `pwd`/wsl/git /usr/local/bin/git
```

## Make links to dotfiles, Windows

```powershell
New-Item  -Force -ItemType HardLink -Path "$env:AppData\alacritty\alacritty.yml" -Target ".\alacritty\alacritty.yml"
New-Item  -Force -ItemType HardLink -Path "$env:AppData\bug.n\Config.ini" -Target ".\bug.n\Config.ini"
New-Item  -Force -ItemType HardLink -Path "$env:AppData\qutebrowser\config\config.py" -Target ".\qutebrowser\config.py"

$wt = Get-Item "$env:LocalAppData\Packages\Microsoft.WindowsTerminal_*"
New-Item  -Force -ItemType HardLink -Path "$wt\LocalState\settings.json" -Target ".\wt\settings.json"

# on Iver laptop
New-Item  -Force -ItemType HardLink -Path "$env:AppData\qutebrowser\config\base_config.py" -Target ".\qutebrowser\config.py"
New-Item  -Force -ItemType HardLink -Path "$env:AppData\qutebrowser\config\config.py" -Target ".\qutebrowser\iver_config.py"
```
