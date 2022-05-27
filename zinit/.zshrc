#if command -v tmux &> /dev/null \
#  && [ -n "$PS1" ] \
#  && [[ ! "$TERM" =~ screen ]] \
#  && [[ ! "$TERM" =~ tmux ]] \
#  && [ -z "$TMUX" ]; then # https://unix.stackexchange.com/a/529049/428922
#  tmux attach -t $(,tmux-first-unattached-session) 2> /dev/null \
#    || tmux new-session
#  exit
#fi

# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
#  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

zi_home="${HOME}/.zi"
source "${zi_home}/bin/zi.zsh"
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

# Snippets
zi is-snippet for \
    has'git' OMZP::git \
    OMZP::colored-man-pages \
    OMZP::command-not-found

# Programs
zi for \
    has'git' as'program' pick'diff-so-fancy' so-fancy/diff-so-fancy \
    has'git' depth=1 wfxr/forgit

zi from'gh-r' as'program' for \
    id-as'kubectx' bpick'kubectx*' ahmetb/kubectx \
    id-as'kubens' bpick'kubens*' ahmetb/kubectx \

# Completions
zi for \
    has'docker' as'completion' OMZP::docker/_docker \
    has'docker-compose' as'completion' OMZP::docker-compose/_docker-compose \
    has'fd' as'completion' OMZP::fd/_fd \
    has'pass' as'completion' OMZP::pass/_pass \
    has'ipfs' as'completion' OMZP::ipfs/_ipfs \
    has'exa' as'completion' https://github.com/ogham/exa/blob/master/completions/zsh/_exa \
    has'podman' as'completion' https://github.com/containers/podman/blob/main/completions/zsh/_podman \
    has'kubectl' OMZP::kubectl \
    has'dotnet' OMZP::dotnet \
    has'npm' OMZP::npm \
    has'node' OMZP::node \
    has'gopass' as'completion' atclone'mv zsh.completion _gopass' https://raw.githubusercontent.com/gopasspw/gopass/master/zsh.completion

cmd_completions() {
    local name="$1"
    local cmd="$@"

    zi for \
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

zi has'kubectx' svn as'completion' light-mode \
    atpull"zi creinstall -q ." \
    atclone'mv _kubectx.zsh _kubectx' \
    atclone'mv _kubens.zsh _kubens' \
    for https://github.com/ahmetb/kubectx/trunk/completion

# Utilities

zi light-mode for \
  atinit"zicompinit; zicdreplay" \
    z-shell/F-Sy-H \
  atload"_zsh_autosuggest_start" \
    zsh-users/zsh-autosuggestions \
  blockf atpull'zi creinstall -q .' \
    zsh-users/zsh-completions

zi light-mode for z-shell/z-a-meta-plugins \
    @romkatv

# Recommended to be loaded last

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
