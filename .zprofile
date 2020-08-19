# Useful default when opening Windows Terminal with relative path but not inside a specific folder
if [[ "$(pwd)" == '/c/Windows/System32' ]]; then
	cd ~
fi

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

# Directories inside Windows host
hash -d documents=/c/Users/kalle.jillheden/Documents
hash -d downloads=/c/Users/kalle.jillheden/Downloads
hash -d desktop=/c/Users/kalle.jillheden/Desktop
hash -d wssh=/c/Users/kalle.jillheden/.ssh

# Mimic Windows environment variables
hash -d profile=/c/Users/kalle.jillheden/ # %USERPROFILE%
hash -d appdata=/c/Users/kalle.jillheden/AppData/Roaming # %APPDATA%
hash -d localappdata=/c/Users/kalle.jillheden/AppData/Local # %LOCALAPPDATA%
hash -d progd=/c/ProgramData # %PROGRAMDATA%
hash -d progf='/c/Program Files' # %PROGRAMFILES%
hash -d progfx='/c/Program Files (x86)' # %PROGRAMFILES(X86)%
hash -d windir='/c/Windows' # %WINDIR%

# Directories inside Linux
hash -d certs=/usr/local/share/ca-certificates
hash -d ssh=~/.ssh

# This is the folders where I keep all my repositories I develop with
hash -d p=/c/Projekt
hash -d dev=~/dev
hash -d river=/c/Projekt/river
hash -d wharf=~/dev/wharf-project
hash -d spark=/c/Projekt/spark
hash -d spark2=/c/Projekt/spark2

# Global aliases
alias -g '%%=| grep'
alias -g '%yaml=| bat -l yaml'
alias -g '%json=| jq'
alias -g '%oyaml=-o yaml | bat -l yaml'
alias -g '%ojson=-o json | jq'

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
alias ls='exa --color=always --group-directories-first -al'
alias kns=kubens
alias kctx=kubectx
alias clip=clip.exe
alias java=java.exe
alias mvn='cmd.exe /c mvn.cmd'
alias start='cmd.exe /c'
alias d=docker
alias dc=docker-compose
alias helm=helm3

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
