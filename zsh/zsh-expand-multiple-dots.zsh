# Taken from https://github.com/parkercoates/dotfiles/blob/77d38713de1aaba4fda1831afee59a8211dbf64c/.zsh/expand-multiple-dots.zsh
# Based on http://stackoverflow.com/a/41420448/4757

function expand-multiple-dots() {
    local MATCH
    if [[ $LBUFFER =~ '(^| )\.\.\.+' ]]; then
        LBUFFER=$LBUFFER:fs%\.\.\.%../..%
    fi
}

function expand-multiple-dots-then-expand-or-complete() {
    zle expand-multiple-dots
    zle expand-or-complete
}

function expand-multiple-dots-then-accept-line() {
    zle expand-multiple-dots
    zle accept-line
}

zle -N expand-multiple-dots
zle -N expand-multiple-dots-then-expand-or-complete
zle -N expand-multiple-dots-then-accept-line
bindkey '^I' expand-multiple-dots-then-expand-or-complete
bindkey '^M' expand-multiple-dots-then-accept-line
