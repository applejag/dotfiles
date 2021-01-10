# Doom Emacs

## Installing

1. Install building dependencies

   ```sh
   sudo apt update
   sudo apt-get install build-essential texinfo libx11-dev libxpm-dev \
       libjpeg-dev libpng-dev libgif-dev libtiff-dev libgtk2.0-dev \
       libncurses-dev libxpm-dev automake autoconf gnutls libgnutls28-dev \
       libjansson-dev
   ```

2. Find version you want from <https://ftp.gnu.org/gnu/emacs/>

3. Download and unpack

   ```sh
   cd ~
   wget https://ftp.gnu.org/gnu/emacs/emacs-27.1.tar.gz
   tar -xf emacs-27.1.tar.gz
   cd emacs-27.1
   ```

4. Configure with native JSON support

   ```sh
   ./configure --with-json
   ```

5. Build

   ```sh
   make
   ```

6. Install Emacs

   ```sh
   sudo make install
   ```

7. Install Doom

   ```sh
   git clone --depth 1 https://github.com/hlissner/doom-emacs ~/.emacs.d
   ~/.emacs.d/bin/doom install
   ```

8. Setup configs

   ```sh
   cd ~/dotfiles
   mkdir -pv ~/.doom.d
   ln -vfs `pwd`/doom/config.el ~/.doom.d/config.el
   ln -vfs `pwd`/doom/packages.el ~/.doom.d/packages.el
   ln -vfs `pwd`/doom/init.el ~/.doom.d/init.el
   ```

9. Sync configs

   ```sh
   ~/.emacs.d/bin/doom sync
   ```

10. Done! Check out the "Install" section in `~/.emacs.d/README.md` for further
   reading.

## go-mode

### Dependencies

```sh
# The -u flag makes it a "get or update"
go get -u golang.org/x/tools/gopls # Language server
go get -u github.com/nsf/gocode # Autocompletion daemon
go get -u github.com/fatih/gomodifytags # Modify struct field tags
go get -u github.com/cweill/gotests/gotests # Test generation
go get -u github.com/motemen/gore/cmd/gore # REPL
go get -u golang.org/x/tools/cmd/guru # Definitions/references navigation + refactoring
go get -u golang.org/x/tools/cmd/goimports # Formatting imports

# golangci-lint is not installed from source as they find it unreliable
# More info: https://golangci-lint.run/usage/install/#install-from-source
curl -sSfL https://raw.githubusercontent.com/golangci/golangci-lint/master/install.sh | sh -s -- -b $(go env GOPATH)/bin v1.35.0
```

### Enable format on save

Will use `goimports` if available. Fallbacks to `gofmt`. Formatter used is
evaluated on startup of emacs.

Persistently enables formatting on save:

```emacs
M-x gofmt-before-save
```

