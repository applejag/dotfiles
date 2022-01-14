source ~/.zprofile_base.zsh

# This is the folders where I keep all my repositories I develop with
hash -d dev=~/dev
hash -d wharf=~/dev/wharf
hash -d ics=~/dev/iver-ics

# Rootfull podman
export DOCKER_HOST=unix:///run/podman/podman.sock
alias d='sudo -E docker'
alias dc='sudo -E docker-compose'
alias p='sudo podman'
