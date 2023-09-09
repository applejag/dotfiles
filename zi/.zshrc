source ~/dotfiles/zsh/zsh-binding-fixes.zsh

. ~/.zshenv

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=3000
SAVEHIST=5000
setopt appendhistory autocd extendedglob nomatch notify histignorealldups interactivecomments
unsetopt beep
bindkey -v
# End of lines configured by zsh-newuser-install

# NixOS home-manager
if [[ -r "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh" ]]; then
  source "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"
fi

if [[ -r "${XDG_CONFIG_HOME:-${HOME}/.config}/zi/init.zsh" ]]; then
  source "${XDG_CONFIG_HOME:-${HOME}/.config}/zi/init.zsh" && zzinit
fi

zi snippet OMZL::clipboard.zsh
zi snippet OMZL::completion.zsh
zi snippet OMZL::termsupport.zsh
zi snippet OMZL::functions.zsh
zi snippet OMZL::git.zsh
zi snippet OMZL::key-bindings.zsh
zi snippet OMZL::misc.zsh

zi snippet OMZP::git
zi load wfxr/forgit

zi light zsh-users/zsh-autosuggestions
zi light z-shell/F-Sy-H

if command -v carapace &> /dev/null; then
  # Completion header
  zstyle ':completion:*' format $'\e[2;37m[%d]\e[m'
  # Grouping
  zstyle ':completion:*:git:*' group-order 'main commands' 'alias commands' 'external commands'
  # compdef
  autoload -Uz compinit; compinit
  source <(carapace _carapace)
fi

# My custom per-command stuff
if [[ -z "$TMUX" ]]; then
  # Namnsdag scripts
  # https://github.com/jilleJr/namnsdag
  if command -v namnsdag &> /dev/null; then
    namnsdag
  fi
fi

if command -v navi &> /dev/null; then
  eval "$(navi widget zsh)"
fi

# Starship loaded last
eval "$(starship init zsh)"
