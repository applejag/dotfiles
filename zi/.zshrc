source ~/dotfiles/zsh/zsh-binding-fixes.zsh

. ~/.zshenv

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=3000
SAVEHIST=5000
setopt appendhistory autocd extendedglob nomatch notify histignorealldups
unsetopt beep
bindkey -v
# End of lines configured by zsh-newuser-install

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
  OMZP::vi-mode \
  has'kubectl' OMZP::kubectl \
  has'helm' OMZP::helm \
  has'terraform' OMZP::terraform

# Other
zi pack"bgn+keys" for fzf

zi wait lucid for \
  wfxr/forgit \
  has'kubectl' bpick"kubectx;kubens" from"gh-r" sbin"kubectx;kubens" ahmetb/kubectx

zi ice lucid wait as'completion' blockf
zi light zchee/zsh-completions

zi as'completion' blockf for \
  has'kubectx' mv'_kubectx.zsh -> _kubectx' https://raw.githubusercontent.com/ahmetb/kubectx/master/completion/_kubectx.zsh \
  has'kubens' mv'_kubens.zsh -> _kubens' https://raw.githubusercontent.com/ahmetb/kubectx/master/completion/_kubens.zsh \
  has'docker' OMZP::docker/_docker

if [[ -z "$TMUX" ]]; then
  # Namnsdag scripts
  # https://github.com/jilleJr/namnsdag
  if command -v namnsdag &> /dev/null; then
    namnsdag
  fi
fi

if command -v aws &> /dev/null
then
  # Support bash completions
  # https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-completion.html#cli-command-completion-enable
  autoload -U bashcompinit
  bashcompinit

  complete -C /usr/local/bin/aws_completer aws
fi

if command -v kubecolor &> /dev/null; then
  autoload -Uz compinit; compinit
  compdef kubecolor=kubectl
fi

if command -v navi &> /dev/null; then
  eval "$(navi widget zsh)"
fi

if command -v kubesess &> /dev/null; then
  source ~/.kube/kubesess/scripts/sh/kubesess.sh
  source ~/.kube/kubesess/scripts/sh/completion.sh
fi

# Starship loaded last
eval "$(starship init zsh)"
