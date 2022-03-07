#!/usr/bin/env bash

set -eo pipefail

sudo apt-get install \
  btrfs-progs \
  git \
  libapparmor-dev \
  iptables \
  libassuan-dev \
  libbtrfs-dev \
  libc6-dev \
  libdevmapper-dev \
  libglib2.0-dev \
  libgpgme-dev \
  libgpg-error-dev \
  libprotobuf-dev \
  libprotobuf-c-dev \
  libseccomp-dev \
  libselinux1-dev \
  libsystemd-dev \
  pkg-config \
  runc \
  uidmap

#  golang-go \
#  go-md2man \
go install github.com/cpuguy83/go-md2man@latest
