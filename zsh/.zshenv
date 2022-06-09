
# Skip the not really helping global compinit
skip_global_compinit=1

export PAGER="less --raw-control-chars --quit-if-one-screen"

# Editor
export EDITOR=nvim

# Go
export PATH="$PATH:/usr/local/go/bin:$HOME/go/bin"

# Doom Emacs
export PATH="$PATH:$HOME/.emacs.d/bin"

# Local binaries
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

# Forgit custom pager
export FORGIT_PAGER=bat

. "$HOME/.cargo/env"
