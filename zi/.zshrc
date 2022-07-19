source ~/dotfiles/zsh/zsh-binding-fixes.zsh

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=3000
SAVEHIST=5000
setopt appendhistory autocd nomatch notify
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
  has'helm' OMZP::helm

# Other
zi pack"bgn+keys" for fzf

zi wait lucid for \
  wfxr/forgit \
  has'kubectl' bpick"kubectx;kubens" from"gh-r" sbin"kubectx;kubens" ahmetb/kubectx

zi as'completion' blockf for \
  has'kubectx' mv'_kubectx.zsh -> _kubectx' https://raw.githubusercontent.com/ahmetb/kubectx/master/completion/_kubectx.zsh \
  has'kubens' mv'_kubens.zsh -> _kubens' https://raw.githubusercontent.com/ahmetb/kubectx/master/completion/_kubens.zsh \
  has'terraform' OMZP::terraform/_terraform \
  has'docker' OMZP::docker/_docker

# Namnsdag scripts
# https://github.com/jilleJr/namnsdag
if command -v namnsdag &> /dev/null; then
  namnsdag
fi

if command -v aws &> /dev/null
then
  # Support bash completions
  # https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-completion.html#cli-command-completion-enable
  autoload -U bashcompinit
  bashcompinit

  complete -C /usr/local/bin/aws_completer aws
fi

# Starship loaded last
eval "$(starship init zsh)"

