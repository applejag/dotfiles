
# Start SSH agent
agent_env=~/.ssh/agent.env

agent_load_env () { test -f "$agent_env" && . "$agent_env" >| /dev/null ; }

agent_start () {
    (umask 077; ssh-agent >| "$agent_env")
    . "$agent_env" >| /dev/null ; }

agent_load_env

# agent_run_state: 0=agent running w/ key; 1=agent w/o key; 2= agent not running
agent_run_state=$(ssh-add -l >| /dev/null 2>&1; echo $?)

if [ ! "$SSH_AUTH_SOCK" ] || [ $agent_run_state = 2 ]; then
    agent_start
    ssh-add
elif [ "$SSH_AUTH_SOCK" ] && [ $agent_run_state = 1 ]; then
    ssh-add
fi

unset agent_env

# Mimic Windows environment variables
hash -d progd=/c/ProgramData # %PROGRAMDATA%
hash -d progf='/c/Program Files' # %PROGRAMFILES%
hash -d progfx='/c/Program Files (x86)' # %PROGRAMFILES(X86)%
hash -d windir='/c/Windows' # %WINDIR%

# Directories inside Linux
hash -d certs=/usr/local/share/ca-certificates
hash -d ssh=~/.ssh

# Global aliases
alias -g '%%=| grep'
alias -g '%yaml=| bat -l yaml'
alias -g '%y=| bat -l yaml'
alias -g '%json=| jq'
alias -g '%j=| jq'
alias -g '%xml=| xmlstarlet fo | bat --language xml'
alias -g '%x=| xmlstarlet fo | bat --language xml'
alias -g '%html=| xmlstarlet fo -H | bat --language html'
alias -g '%h=| xmlstarlet fo -H | bat --language html'
alias -g '%oyaml=-o yaml | bat -l yaml'
alias -g '%oy=-o yaml | bat -l yaml'
alias -g '%ojson=-o json | jq'
alias -g '%oj=-o json | jq'
alias -g '%jwt= | jwt decode - | bat --language json'

# Easy history navigation
setopt autopushd
alias 0='dirs -v | head -10'
alias 1='cd -'
alias 2='cd -2'
alias 3='cd -3'
alias 4='cd -4'
alias 5='cd -5'
alias 6='cd -6'
alias 7='cd -7'
alias 8='cd -8'
alias 9='cd -9'

# Commands
alias ls='exa --color=always --group-directories-first -al --icons'
alias kns=kubens
alias kctx=kubectx
alias start='cmd.exe /c'
alias d=docker
alias dc=docker-compose
alias helm=helm3
alias cr='crystal run'
alias cb='crystal build'
alias '?=todo --flat'

if command -v gocopy.exe &> /dev/null; then
    alias clip=gocopy.exe
else
    alias clip=clip.exe
fi

if command -v bat &> /dev/null; then
    alias cat='bat --decorations never'

    function _todo_task_pretty() {
      todo task "$@" >/dev/null
      todo task "$1" | bat --language md --theme DarkNeon
    }

    alias '?#'=_todo_task_pretty

    funciton _todo_done_pretty() {
      todo done "$@"
      todo task "$1" | bat --language md --theme DarkNeon
    }

    alias '?!'=_todo_done_pretty
fi

if ! command -v fd &> /dev/null \
  && command -v fdfind &> /dev/null
then
  alias fd=fdfind
fi

# Missing aliases from kubectl OMZ plugin
alias kd='kubectl describe'
alias kg='kubectl get'
alias ke='kubectl edit'

alias kesec='kubectl edit secret'

alias kdelir='kubectl delete ingressroute'
alias kdir='kubectl describe ingressroute'
alias keir='kubectl edit ingressroute'
alias kgir='kubectl get ingressroute'
alias kgira='kubectl get ingressroute --all-namespaces'

alias kdelsa='kubectl delete serviceaccount'
alias kdsa='kubectl describe serviceaccount'
alias kesa='kubectl edit serviceaccount'
alias kgsa='kubectl get serviceaccount'
alias kgsaa='kubectl get serviceaccount --all-namespaces'
