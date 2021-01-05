# Skip the not really helping Ubuntu global compinit
skip_global_compinit=1

# Krew - Kubectl plugin manager
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

# Rust/Cargo
export PATH="$HOME/.cargo/bin:$PATH"

# GoLang
export PATH="$PATH:/usr/local/go/bin:${GOHOME:-$HOME/go}/bin"

# Dotnet tool
export PATH="$PATH:$HOME/.dotnet/tools"

# Doom Emacs
export PATH="$PATH:$HOME/.emacs.d/bin"

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

# GPG fix
export GPG_TTY="$(tty)"

# Enable pass extensions
export PASSWORD_STORE_ENABLE_EXTENSIONS=true

# forgit custom pager
export FORGIT_PAGER='cat'

# X11 display, customly made for WSL2
export DISPLAY=$(awk '/nameserver / {print $2; exit}' /etc/resolv.conf 2>/dev/null):0
export LIBGL_ALWAYS_INDIRECT=1

# FZF customization
export FZF_COMPLETION_TRIGGER='~~'
export FZF_DEFAULT_COMMAND='fd --type f --hidden --exclude .git'

# Term setting
export TERM=xterm-256color
