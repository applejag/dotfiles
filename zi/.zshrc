# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=3000
SAVEHIST=5000
setopt autocd extendedglob nomatch notify
unsetopt beep
bindkey -e

if [[ ! -f $HOME/.zi/bin/zi.zsh ]]; then
  print -P "%F{33}▓▒░ %F{160}Installing (%F{33}z-shell/zi%F{160})…%f"
  command mkdir -p "$HOME/.zi" && command chmod g-rwX "$HOME/.zi"
  command git clone -q --depth=1 --branch "main" https://github.com/z-shell/zi "$HOME/.zi/bin" && \
    print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
    print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

source "$HOME/.zi/bin/zi.zsh"
autoload -Uz _zi
(( ${+_comps} )) && _comps[zi]=_zi
zicompinit

zi light-mode for \
  z-shell/z-a-meta-plugins \
  @annexes \
  @zsh-users+fast

# Sets F-Sy-H theme
fast-theme -q default

# Oh-my-zsh library files
zi is-snippet svn pick"completion.zsh" src"git.zsh" for OMZ::lib

# Oh-my-zsh plugins
zi for \
  OMZP::git \
  OMZP::vi-mode


# Other
zi pack"bgn+keys" for fzf

zi wait lucid for \
  wfxr/forgit

zicompinit

# Namnsdag scripts
# https://github.com/jilleJr/namnsdag
if command -v namnsdag &> /dev/null; then
  namnsdag
fi

# Starship loaded last
eval "$(starship init zsh)"

