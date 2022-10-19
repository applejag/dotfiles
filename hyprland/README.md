# Hyprland

```sh
sudo dnf install \
	cmake \
	ninja-build \
  cairo-devel \
  gcc-c++ \
  libX11-devel \
  libxcb-devel \
  meson \
  pango-devel \
  pixman-devel \
  wayland-protocols-devel
```

```sh
# https://github.com/hyprwm/Hyprland/discussions/284#discussioncomment-3893343
mkdir ~/code/libdrm
cd ~/code/libdrm
wget https://dri.freedesktop.org/libdrm/libdrm-2.4.113.tar.xz

tar xf libdrm-2.4.113.tar.xz
cd libdrm-2.4.113
mkdir build
cd build

meson --prefix=/usr/local
 
ninja
sudo ninja install
```

```sh
sudo dnf install -y \
    git \
    cmake \
    gcc \
    gcc-c++ \
    ninja-build \
    vulkan \
    libvkd3d \
    vulkan-loader-devel \
    python3-pip \
    libglvnd-devel \
    libfontenc-devel \
    libXaw-devel \
    libXcomposite-devel \
    libXcursor-devel \
    libXdmcp-devel \
    libXtst-devel \
    libXinerama-devel \
    libxkbfile-devel \
    libXrandr-devel \
    libXres-devel \
    libXScrnSaver-devel \
    libXvMC-devel \
    xorg-x11-xtrans-devel \
    xcb-util-wm-devel \
    xcb-util-image-devel \
    xcb-util-keysyms-devel \
    xcb-util-renderutil-devel \
    libXdamage-devel \
    libXxf86vm-devel \
    libXv-devel \
    xcb-util-devel \
    libuuid-devel \
    xkeyboard-config-devel \
    glslang-devel

pip install wheel setuptools conan

git clone https://github.com/inexorgame/vulkan-renderer ~/code/vulkan-renderer
cd ~/code/vulkan-renderer

cmake . -Bbuild -DCMAKE_BUILD_TYPE=Release -GNinja && ninja -C build

# Edit ~/.conan/settings.yml if errors arise on above command.
# https://inexor-vulkan-renderer.readthedocs.io/en/latest/development/building.html#f2

# Currently fails because of:
# - https://github.com/conan-io/conan/issues/12320
# - https://github.com/conan-io/conan-center-index/issues/13588
```

```sh
git clone --recursive https://github.com/hyprwm/Hyprland ~/code/hyprland

cd ~/code/hyprland
meson _build
ninja -C _build
sudo ninja -C _build install

sudo cp /usr/local/share/wayland-sessions/hyprland.desktop /usr/share/wayland-sessions

ln -vfs ~/dotfiles/hyprland ~/.config/hypr
```
