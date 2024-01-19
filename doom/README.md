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

## Installing Emacs

```sh
# Download and unpack
git clone git://git.savannah.gnu.org/emacs.git ~/emacs
cd ~/emacs

# Configure with native JSON and GCC JIT support
./autogen.sh && \
./configure --with-json --with-native-compilation && \
make -j$(nproc)

# Install Emacs
sudo make install
```

## Installing Doom

```sh
# Install Doom
ln -vfs ~/{dotfiles,.config}/doom

git clone --depth 1 https://github.com/doomemacs/doomemacs ~/.config/emacs
~/.config/emacs/bin/doom install
```

Done! Check out the "Install" section in `~/.emacs.d/README.md` for further
reading.

## go-mode

### Dependencies

```sh
./install-go-deps.sh
```

### Enable format on save

Will use `goimports` if available. Fallbacks to `gofmt`. Formatter used is
evaluated on startup of emacs.

Persistently enables formatting on save:

```emacs
M-x gofmt-before-save
```

