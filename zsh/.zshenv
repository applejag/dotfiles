
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
if [ -d "$HOME/.local/bin" ]; then
    PATH="$HOME/.local/bin:$PATH"
fi

# Forgit custom pager
export FORGIT_PAGER=bat

# JQ custom color palette
# null:false:true:numbers:strings:arrays:objects
# Can't set key color though: https://github.com/stedolan/jq/pull/1791
export JQ_COLORS="1;30:0;95:0;95:0;95:0;32:0:0"

. "$HOME/.cargo/env"

if [ -e $HOME/.nix-profile/etc/profile.d/nix.sh ]; then . $HOME/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer
