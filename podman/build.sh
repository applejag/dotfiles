#!/usr/bin/env bash

{
  git clone https://github.com/containers/conmon
  cd conmon
  export GOCACHE="$(mktemp -d)"
  make
  sudo make podman
}

{
  git clone https://github.com/containers/podman
  cd podman
  make BUILDTAGS="selinux seccomp"
  sudo -E make install PREFIX=/usr
}
