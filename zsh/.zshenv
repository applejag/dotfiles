
# Skip the not really helping global compinit
skip_global_compinit=1

export PAGER="less --raw-control-chars --quit-if-one-screen"

# Shell
export SHELL=/bin/zsh

# Kind: Kubernetes-in-Docker
export KIND_EXPERIMENTAL_PROVIDER=podman

# goss/dgoss
export CONTAINER_RUNTIME=podman

# Kubectl krew
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

# Editor
export EDITOR=nvim

# Go
# Add it first to have higher prio than OS-package version
export PATH="/usr/local/go/bin:$HOME/go/bin:$PATH"

# Node
export PATH="$PATH:./node_modules/.bin"
# pnpm
export PNPM_HOME="$HOME/.local/share/pnpm"
export PATH="$PNPM_HOME:$PATH"
# pnpm end

# Doom Emacs
export PATH="$PATH:$HOME/.emacs.d/bin"

# Linkerd2
export PATH="$PATH:$HOME/.linkerd2/bin"

# Ansible
export ANSIBLE_VAULT_IDENTITY_LIST="$HOME/dotfiles/scripts/ansible-vault-keyring-client.py"
export ANSIBLE_RETRY_FILES_ENABLED=True

# Local binaries
if [ -d "$HOME/.local/bin" ]; then
    PATH="$HOME/.local/bin:$PATH"
fi

# Forgit custom pager
export FORGIT_PAGER=bat

if command -v delta &> /dev/null
then
    export FORGIT_DIFF_PAGER='delta --line-numbers'
    export FORGIT_SHOW_PAGER='delta --line-numbers'
fi

# Fix for Zi x OMZ
ZSH_CACHE_DIR="$HOME/.zi"

# JQ custom color palette
# null:false:true:numbers:strings:arrays:objects
# Can't set key color though: https://github.com/stedolan/jq/pull/1791
export JQ_COLORS="1;30:0;95:0;95:0;95:0;32:0:0"

if [ -f "$HOME/.cargo/env" ]; then
    source "$HOME/.cargo/env"
fi

if [ -d "$HOME/.deno" ]; then
    export DENO_INSTALL="$HOME/.deno"
    export PATH="$DENO_INSTALL/bin:$PATH"
fi

if [ -e $HOME/.nix-profile/etc/profile.d/nix.sh ]; then . $HOME/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer
