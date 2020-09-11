# Dotfiles of jilleJr

## Make links to dotfiles, Linux

```sh
ln -s `pwd`/zsh/.zprofile ~/.zprofile
ln -s `pwd`/zsh/.zshenv ~/.zshenv
ln -s `pwd`/zinit/.zshrc ~/.zshrc
ln -s `pwd`/zsh/.p10k.zsh ~/.p10k.zsh
sudo ln -s `pwd`/wsl/git /usr/local/bin/git
```

## Make links to dotfiles, Windows

```powershell
New-Item -ItemType HardLink -Path "$env:AppData\alacritty\alacritty.yml" -Target ".\alacritty\alacritty.yml"
New-Item -ItemType HardLink -Path "$env:AppData\bug.n\Config.ini" -Target ".\bug.n\Config.ini"
New-Item -ItemType HardLink -Path "$env:AppData\qutebrowser\config\config.py" -Target ".\qutebrowser\iver_config.py"

$wt = Get-Item "$env:LocalAppData\Packages\Microsoft.WindowsTerminal_*"
New-Item -ItemType HardLink -Path "$wt\LocalState\settings.json" -Target ".\wt\settings.json"
```
