# Skip the not really helping Ubuntu global compinit
skip_global_compinit=1

# Krew - Kubectl plugin manager
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

# GoLang
export PATH="$PATH:/usr/local/go/bin:${GOHOME:-$HOME/go}/bin"

# Dotnet tool
export PATH="$PATH:$HOME/.dotnet/tools"

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
