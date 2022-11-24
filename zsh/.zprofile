
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

# Directories inside Linux
if grep -q '^ID=fedora$' /etc/os-release; then
  hash -d certs=/etc/pki/ca-trust/source/anchors
else
  hash -d certs=/usr/local/share/ca-certificates
fi
hash -d c=~/code
hash -d w=~/code/wharf
hash -d j=~/code/jillejr
hash -d n=~/Documents/notes
hash -d ri=~/code/risk.ident
hash -d rip=~/code/risk.ident/platform

# Global aliases
alias -g '%%=| grep'
alias -g '%y=| bat -l yaml'
alias -g '%yq=| yq eval'
alias -g '%j=| bat -l json'
alias -g '%jq=| jq'
alias -g '%xml=| xmlstarlet fo | bat --language xml'
alias -g '%x=| xmlstarlet fo | bat --language xml'
alias -g '%html=| xmlstarlet fo -H | sed "s/\]\]>//g; s/<!\[CDATA\[//g" |  bat --language html'
alias -g '%h=| xmlstarlet fo -H | bat --language html'
alias -g '%oy=-o yaml | bat -l yaml'
alias -g '%doy=--dry-run=client -o yaml | bat -l yaml'
alias -g '%oyq=-o yaml | yq eval'
alias -g '%oj=-o json | bat -l json'
alias -g '%doj=--dry-run=client -o json | bat -l json'
alias -g '%ojq=-o json | jq'
alias -g '%jwt= | jwt decode - | bat --language json'
alias -g '%osks= -o yaml | showksec | bat --language yaml'
alias -g '%sks= | showksec | bat --language yaml'
alias -g '%l= | relog'

alias -g '%b64d= | base64 -d'
alias -g '%b64= | base64'
alias -g '%b64dx509= | base64 -d | openssl x509 -noout -text'
alias -g '%x509= | openssl x509 -noout -text'
alias -g "%ocacrt=-o json | jq '.data[\"ca.crt\"]' -r | base64 -d | openssl x509 -noout -text"
alias -g "%otlscrt=-o json | jq '.data[\"tls.crt\"]' -r | base64 -d | openssl x509 -noout -text"

source ~/dotfiles/zsh/zsh-expand-multiple-dots.zsh

# Easy history navigation
setopt autopushd
alias -- -='cd -'
alias 0='dirs -v | head -10'
alias 1='cd $(dirs -lp | head -2 | tail -1)'
alias 2='cd $(dirs -lp | head -3 | tail -1)'
alias 3='cd $(dirs -lp | head -4 | tail -1)'
alias 4='cd $(dirs -lp | head -5 | tail -1)'
alias 5='cd $(dirs -lp | head -6 | tail -1)'
alias 6='cd $(dirs -lp | head -7 | tail -1)'
alias 7='cd $(dirs -lp | head -8 | tail -1)'
alias 8='cd $(dirs -lp | head -9 | tail -1)'
alias 9='cd $(dirs -lp | head -10 | tail -1)'

# Commands
if command -v crystal &> /dev/null; then
  alias c=crystal
fi
alias kns=kubens
alias kctx=kubectx
if command -v helm3 &> /dev/null; then
  alias helm=helm3
fi
if command -v dinkur &> /dev/null; then
  alias u=dinkur
  alias '?=dinkur ls'
  alias uy='dinkur ls -r yesterday'
  alias ud='dinkur ls -r today'
  alias uw='dinkur ls -r week'
  alias ua='dinkur ls -r all'
fi
alias e='emacsclient -c -a "emacs"'
alias xo=xdg-open
alias sudo='sudo env PATH=$PATH'

if command -v brave-browser &> /dev/null; then
  alias musicforprogramming='brave-browser "ipns://mfp.jillejr.tech/?$(rng 1 63 -f english | tr -d -)" &> /dev/null &'
else
  alias musicforprogramming='xdg-open "https://musicforprogramming.net/?$(rng 1 63 -f english | tr -d -)"'
fi

ORIG_GOPASS="$(command -v gopass)"
if [[ $? == 0 ]]; then
  alias pass='gopass'
  gopass() {
    if [[ "$1" =~ / || "$1" == "show" ]]; then
      "$ORIG_GOPASS" "$@" | bat --language yaml --decorations never
    else
      "$ORIG_GOPASS" "$@"
    fi
  }
fi

# Additional git aliases
alias gla='git pull --all --prune --jobs=10'
# Resetting weird Forgit aliases
export forgit_checkout_commit=gcoc
alias gco='git checkout'

if command -v exa &> /dev/null; then
  alias ls='exa --color=always --group-directories-first -al --icons --git'
fi

alias p=podman

if command -v docker-compose &> /dev/null; then
  alias dc=docker-compose
elif command -v podman-compose &> /dev/null; then
  alias dc=podman-compose
  alias docker-compose=podman-compose
fi

if ! command -v fd &> /dev/null \
  && command -v fdfind &> /dev/null
then
  alias fd=fdfind
fi

if command -v bat &> /dev/null; then
  alias cat='bat --decorations never'
fi

# Missing aliases from kubectl OMZ plugin
alias kd='kubectl describe'
alias kg='kubectl get'
alias ke='kubectl edit'
alias kv='kubectl version --short'

alias kdg='kubectl debug'
alias kdgti='kubectl debug -it'

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

alias kdelj='kubectl delete job'
alias kdj='kubectl describe job'
alias kej='kubectl edit job'
alias kgj='kubectl get job'
alias kgja='kubectl get job --all-namespaces'

alias kdelcj='kubectl delete cronjob'
alias kdcj='kubectl describe cronjob'
alias kecj='kubectl edit cronjob'
alias kgcj='kubectl get cronjob'
alias kgcja='kubectl get cronjob --all-namespaces'

alias kdelc='kubectl delete certificate'
alias kdc='kubectl describe certificate'
alias kec='kubectl edit certificate'
alias kgc='kubectl get certificate'
alias kgca='kubectl get certificate --all-namespaces'

alias kdelcsec='kubectl delete clustersecret'
alias kdcsec='kubectl describe clustersecret'
alias kecsec='kubectl edit clustersecret'
alias kgcsec='kubectl get clustersecret'
alias kgcseca='kubectl get clustersecret --all-namespaces'

if command -v kubectl-hns &> /dev/null; then
  alias kh=kubectl-hns
  alias kht='kubectl-hns tree'
  alias khd='kubectl-hns describe'
  if command -v hns-tree &> /dev/null; then
    alias khta='hns-tree'
  else
    alias khta='kubectl-hns tree --all-namespaces'
  fi
fi

# Colored kubectl output
if command -v kubecolor &> /dev/null; then
  alias kubectl=kubecolor
  export KUBECOLOR_OBJ_FRESH='2h'
fi

fpath+="$HOME/.cache/zi/completions"

if command -v ansible &> /dev/null
then
  # Support bash completions
  # https://kislyuk.github.io/argcomplete/#zsh-support
  autoload -U bashcompinit
  bashcompinit

  # Ansible completions
  # https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html#configuring-argcomplete
  eval $(register-python-argcomplete ansible)
  eval $(register-python-argcomplete ansible-config)
  eval $(register-python-argcomplete ansible-console)
  eval $(register-python-argcomplete ansible-doc)
  eval $(register-python-argcomplete ansible-galaxy)
  eval $(register-python-argcomplete ansible-inventory)
  eval $(register-python-argcomplete ansible-playbook)
  eval $(register-python-argcomplete ansible-pull)
  eval $(register-python-argcomplete ansible-vault)
fi

if command -v glow &> /dev/null
then
  autoload -U add-zsh-hook
  glow-readme-on-cd() {
    ~/dotfiles/scripts/glow-readme-on-cd.zsh
  }
  add-zsh-hook chpwd glow-readme-on-cd
fi
