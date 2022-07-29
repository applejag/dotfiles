# Doom Emacs

## Dependencies

Ubuntu/Debian:

```sh
sudo apt update
sudo apt-get install build-essential texinfo libx11-dev libxpm-dev \
    libjpeg-dev libpng-dev libgif-dev libtiff-dev libgtk2.0-dev \
    libncurses-dev libxpm-dev automake autoconf libgnutls28-dev \
    libjansson-dev libgccjit-11-dev
```

Fedora:

```sh
sudo dnf install gcc gcc-c++ texinfo \
    gtk+-devel gtk4-devel gnutls-devel \
    libjpeg-devel libpng-devel giflib-devel libtiff-devel libXpm-devel \
    ncurses-devel libX11-devel libXaw-devel make automake autoconf \
    jansson-devel libgccjit-devel
```

NixOS:

```sh
nix-env -i \
   --extra-experimental-features nix-command \
   libgccjit libpng libjpeg giflib libtiff librsvg libwebp \
   gconf pkg-config texinfo gettext acl harfbuzz sqlite \
   gsettings-desktop-schemas jansson

nix-env -iA nixos.gtk3-x11
```

## Installing

1. Download and unpack

   ```sh
   git clone git://git.savannah.gnu.org/emacs.git ~/emacs
   cd ~/emacs
   ```

2. Configure with native JSON and GCC JIT support

   ```sh
   ./autogen.sh && \
   ./configure --with-json --with-native-compilation && \
   make -j$(nproc)
   ```

3. Install Emacs

   ```sh
   sudo make install
   ```

4. Install Doom

   ```sh
   cd ~/dotfiles
   ln -vfs `pwd`/doom ~/.doom.d

   git clone --depth 1 https://github.com/hlissner/doom-emacs ~/.emacs.d
   ~/.emacs.d/bin/doom install
   ```

5. Done! Check out the "Install" section in `~/.emacs.d/README.md` for further
   reading.

## go-mode

### Dependencies

```sh
# The -u flag makes it a "get or update"
go install golang.org/x/tools/gopls@latest # Language server
go install github.com/nsf/gocode@latest # Autocompletion daemon
go install github.com/mdempsky/gocode@latest   # for code completion
go install github.com/fatih/gomodifytags@latest # Modify struct field tags
go install github.com/cweill/gotests/gotests@latest # Test generation
go install github.com/x-motemen/gore/cmd/gore@latest # REPL
go install golang.org/x/tools/cmd/guru@latest # Definitions/references navigation + refactoring
go install golang.org/x/tools/cmd/goimports@latest # Formatting imports

# golangci-lint is not installed from source as they find it unreliable
# More info: https://golangci-lint.run/usage/install/#install-from-source
curl -sSfL https://raw.githubusercontent.com/golangci/golangci-lint/master/install.sh | sh -s -- -b $(go env GOPATH)/bin v1.46.2
```

### Enable format on save

Will use `goimports` if available. Fallbacks to `gofmt`. Formatter used is
evaluated on startup of emacs.

Persistently enables formatting on save:

```emacs
M-x gofmt-before-save
```

