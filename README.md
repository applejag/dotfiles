# Dotfiles of jilleJr

## Make links to dotfiles, Linux

```sh
ln -s ~/.zprofile ./zsh/.zprofile
ln -s ~/.zshenv ./zsh/.zshenv
ln -s ~/.zshrc ./zsh/.zshrc
ln -s ~/.p10k.zsh ./zsh/.p10k.zsh
```

## Make links to dotfiles, Windows

```powershell
New-Item -ItemType HardLink -Path "$env:AppData\alacritty\alacritty.yml" -Target ".\alacritty\alacritty.yml"
New-Item -ItemType HardLink -Path "$env:AppData\bug.n\Config.ini" -Target ".\bug.n\Config.ini"
```

