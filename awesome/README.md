
```sh
mkdir -pv ~/code
git clone https://github.com/awesomeWM/awesome ~/code/awesome
```

## Fedora dependencies

```sh
sudo dnf install \
  lua \
	lua-devel \
	dbus-devel \
	libxkbcommon-x11-devel \
	libxdg-basedir-devel \
	libxcb-devel \
	xcb-util-devel \
	xcb-util-cursor-devel \
	xcb-util-keysyms-devel \
	xcb-util-wm-devel \
	xcb-util-xrm-devel \
	startup-notification-devel
```

## Building

```sh
cd ~/code/awesome

make

sudo make install
```
