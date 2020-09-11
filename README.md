# Dotfiles of jilleJr

## Make links to dotfiles, Linux

```sh
ln -s `pwd`/zsh/.zprofile ~/.zprofile
ln -s `pwd`/zsh/.zshenv ~/.zshenv
ln -s `pwd`/zinit/.zshrc ~/.zshrc
ln -s `pwd`/zsh/.p10k.zsh ~/.p10k.zsh
```

## Make links to dotfiles, Windows

```powershell
New-Item -ItemType HardLink -Path "$env:AppData\alacritty\alacritty.yml" -Target ".\alacritty\alacritty.yml"
New-Item -ItemType HardLink -Path "$env:AppData\bug.n\Config.ini" -Target ".\bug.n\Config.ini"
```

