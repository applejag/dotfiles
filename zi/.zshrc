#if command -v tmux &> /dev/null \
#  && [ -n "$PS1" ] \
#  && [[ ! "$TERM" =~ screen ]] \
#  && [[ ! "$TERM" =~ tmux ]] \
#  && [ -z "$TMUX" ]; then
#  # https://unix.stackexchange.com/a/529049/428922
#  tmux attach -t $(,tmux-first-unattached-session) 2> /dev/null \
#    || tmux new-session
#  exit
#fi

# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
#  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Load Zi
zi_home="${HOME}/.zi"
source "${zi_home}/bin/zi.zsh"
# Zi autocompletions
autoload -Uz _zi
(( ${+_comps} )) && _comps[zi]=_zi

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=2000
SAVEHIST=2000
setopt appendhistory autocd beep extendedglob nomatch notify
bindkey -v
# End of lines configured by zsh-newuser-install

# Oh-My-Zsh conf
export ZSH="/home/kalle/.oh-my-zsh"

# OMZ libraries. Should be loaded before any OMZ plugins
zi svn multisrc'*.zsh' blockf is-snippet for OMZ::lib

# Zi annexes: https://z.digitalclouds.dev/ecosystem/annexes/meta-plugins#the-list-of-available-meta-plugins
zi light-mode for z-shell/z-a-meta-plugins @annexes \
    @zsh-users+fast \
    @romkatv

# Snippets
zi is-snippet for \
    has'git' OMZP::git \
    OMZP::colored-man-pages \
    OMZP::command-not-found

zi is-snippet for \
    OMZP::vi-mode

# Programs
zi for \
    has'git' as'program' pick'diff-so-fancy' so-fancy/diff-so-fancy \
    has'git' depth=1 wfxr/forgit

zi pack'binary+keys' for fzf

zi from'gh-r' as'program' for \
    id-as'kubectx' bpick'kubectx*' ahmetb/kubectx \
    id-as'kubens' bpick'kubens*' ahmetb/kubectx \

# Completions
zi for \
    has'docker' as'completion' OMZP::docker/_docker \
    has'docker-compose' as'completion' OMZP::docker-compose/_docker-compose \
    has'fd' as'completion' OMZP::fd/_fd \
    as'completion' OMZP::pass/_pass \
    has'ipfs' as'completion' OMZP::ipfs/_ipfs \
    as'completion' https://github.com/ogham/exa/blob/master/completions/zsh/_exa \
    as'completion' https://github.com/samg/timetrap/blob/master/completions/zsh/_t \
    as'completion' https://github.com/containers/podman/blob/main/completions/zsh/_podman \
    has'kubectl' atclone"mkdir -pv $ZSH_CACHE_DIR/completions" OMZP::kubectl \
    has'helm' atclone"mkdir -pv $ZSH_CACHE_DIR/completions" OMZP::helm \
    has'dotnet' OMZP::dotnet \
    has'npm' OMZP::npm \
    has'node' OMZP::node \
    has'gopass' as'completion' atclone'mv zsh.completion _gopass' https://raw.githubusercontent.com/gopasspw/gopass/master/zsh.completion

zi svn as'completion' light-mode \
    atpull"zi creinstall -q ." \
    atclone'mv _kubectx.zsh _kubectx' \
    atclone'mv _kubens.zsh _kubens' \
    for https://github.com/ahmetb/kubectx/trunk/completion

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

autoload -Uz compinit
compinit
zi cdreplay -q

if command -v namnsdag &> /dev/null; then
  namnsdag
elif [ -x ~/dotfiles/scripts/namnsdag.sh ]; then
  ~/dotfiles/scripts/namnsdag.sh
fi

if command -v todo &> /dev/null; then
  TASK_COUNT=$(todo --flat | wc -l)
  if [ $TASK_COUNT = 0 ]; then
    echo -e "\e[90m=== Nothing on your todo list\e[0m"
  else
    echo -e "\e[90m=== \e[33mTodo: 📝 $TASK_COUNT tasks \e[90m\e[0m"
    todo --flat
  fi
fi
