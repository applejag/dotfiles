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

source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[_zinit]=_zinit

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=2000
SAVEHIST=2000
setopt appendhistory autocd beep extendedglob nomatch notify
bindkey -v
# End of lines configured by zsh-newuser-install

# Oh-My-Zsh conf
export ZSH="/home/kalle/.oh-my-zsh"

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zinit-zsh/z-a-patch-dl \
    zinit-zsh/z-a-as-monitor \
    zinit-zsh/z-a-bin-gem-node

# OMZ libraries. Should be loaded before any OMZ plugins
zinit svn multisrc'*.zsh' blockf is-snippet for OMZ::lib

# Snippets
zinit is-snippet for \
    has'git' OMZP::git \
    OMZP::colored-man-pages \
    OMZP::command-not-found

zinit is-snippet for \
    OMZP::vi-mode

# Programs
zinit for \
    has'git' as'program' pick'diff-so-fancy' so-fancy/diff-so-fancy \
    has'git' depth=1 wfxr/forgit

zinit pack'binary+keys' for fzf

zinit from'gh-r' as'program' for \
    id-as'kubectx' bpick'kubectx*' ahmetb/kubectx \
    id-as'kubens' bpick'kubens*' ahmetb/kubectx \

# Completions
zinit for \
    as'completion' OMZP::docker/_docker \
    as'completion' OMZP::fd/_fd \
    as'completion' OMZP::pass/_pass \
    as'completion' https://github.com/ogham/exa/blob/master/completions/zsh/_exa \
    as'completion' https://github.com/samg/timetrap/blob/master/completions/zsh/_t \
    as'completion' https://github.com/containers/podman/blob/main/completions/zsh/_podman \
    OMZP::kubectl \
    has'dotnet' OMZP::dotnet \
    has'ipfs' OMZP::ipfs/_ipfs \
    has'npm' OMZP::npm \
    has'node' OMZP::node

cmd_completions() {
    local name="$1"
    local cmd="$@"

    zinit for \
        has"${name}" \
        id-as"${name}_completion" \
        as'completion' \
        atclone"${cmd} > _${name}" \
        atpull'%atclone' \
        run-atpull \
        zdharma/null
}

cmd_completions kubectl completion zsh
cmd_completions helm completion zsh

zinit svn as'completion' light-mode \
    atpull"zinit creinstall -q ." \
    atclone'mv kubectx.zsh _kubectx' \
    atclone'mv kubens.zsh _kubens' \
    for https://github.com/ahmetb/kubectx/trunk/completion

# Utilities
zinit light-mode for \
    zdharma/fast-syntax-highlighting

zinit atload'_zsh_autosuggest_start' light-mode for \
    zsh-users/zsh-autosuggestions

zinit depth=1 light-mode for romkatv/powerlevel10k

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Recommended to be loaded last
zinit lucid blockf atpull'zinit creinstall -q' light-mode for \
    zsh-users/zsh-completions

autoload -Uz compinit
compinit
zinit cdreplay -q

if [ -x ~/dotfiles/scripts/namnsdag.sh ]; then
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
