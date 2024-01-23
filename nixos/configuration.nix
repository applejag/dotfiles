# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running `nixos-help`).


{ config, pkgs, lib, ... }:

{
  imports =
    [ 
      <nixos-hardware/lenovo/thinkpad/t14>
      # Include the results of the hardware scan.
      ./hardware-configuration.nix

      # https://github.com/jonascarpay/declarative-cachix
      (import (builtins.fetchTarball "https://github.com/jonascarpay/declarative-cachix/archive/abe4d70e5d9a225a7ecf98086b089cc04202f2e3.tar.gz"))
    ];

  cachix = [
    "nix-community"
  ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.plymouth = {
    enable = true;
    theme = "breeze";
  };
  boot.initrd.systemd.enable = true;

  boot.tmp.cleanOnBoot = true;

  networking.hostName = "ri-t-0790"; # Define your hostname.
  # Pick only one of the below networking options.
  #networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  networking.hosts = {
    "52.204.183.147" = [ "lalia-berlin.com" ];
  };

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkbOptions in tty.
  # };

  # Enable the X11 windowing system.
  # services.xserver.enable = true;
  

  # Configure keymap in X11
  # services.xserver.layout = "us";
  # services.xserver.xkbOptions = "eurosign:e,caps:escape";

  # Enable CUPS to print documents.
  services.printing = {
    enable = true;
    drivers = with pkgs; [
      gutenprint
    ];
  };
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  # Hardware-accelerated video encoding/decoding
  # https://nixos.wiki/wiki/Accelerated_Video_Playback
  nixpkgs.config.packageOverrides = pkgs: {
    vaapiIntel = pkgs.vaapiIntel.override { enableHybridCodec = true; };
  };

  hardware.opengl = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver
      vaapiIntel # older but works better for Firefox/Chromium
      vaapiVdpau # VDPAU driver for the VAAPI lib
      libvdpau-va-gl # VDPAU driver with OpenGL/VAAPI backend
      libvpx # WebM VP8/VP9 codec
    ];
  };

  # Enable sound.
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    # This should be supported, but I get error:
    # "The option `services.pipewire.alsa.support32bit' does not exist."
    #alsa.support32bit = true;
    pulse.enable = true;
  };

  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  services.greetd = {
    enable = true;
    # https://man.sr.ht/~kennylevinsen/greetd/
    settings = {
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --user-menu --asterisks --remember --remember-session --time --cmd Hyprland";
        user = "greeter";
      };
    };
  };
  environment.etc."greetd/environments".text = ''
    zsh
    Hyprland
  '';

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.kallefagerberg = {
    isNormalUser = true;
    extraGroups = [
      "wheel" # Enable ‘sudo’ for the user.
      "libvirtd" # Run VMs without needing sudo
    ];
  };

  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-emoji
    monocraft
    ubuntu_font_family
    font-awesome
    (nerdfonts.override { fonts = [ "FiraCode" ]; })
  ];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    curlHTTP3
    file
    gnumake
    htop
    killall
    wget
    xdg-utils
  ];

  
  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "1password"
    "1password-cli"
  ];

  programs._1password.enable = true;
  programs._1password-gui.enable = true;
  programs._1password-gui.polkitPolicyOwners = [ "kallefagerberg" ];

  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
  };
  # For virt-manager
  # https://nixos.wiki/wiki/Virt-manager
  virtualisation.libvirtd.enable = true;
  programs.dconf.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    #enableSSHSupport = true;
    pinentryFlavor = "qt";
  };

  programs.hyprland.enable = true;
  # Hint electron apps to use Wayland
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  security.pam.services.swaylock.text = ''
    auth include login
  '';

  services.gnome.gnome-keyring.enable = true;
  programs.seahorse.enable = true;

  security.polkit.enable = true;

  # KDE polkit
  systemd.user.services.polkit-kde-authentication-agent-1 = {
    description = "polkit-kde-authentication-agent-1";
    wantedBy = [ "graphical-session.target" ];
    wants = [ "graphical-session.target" ];
    after = [ "graphical-session.target" ];
    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.libsForQt5.polkit-kde-agent}/libexec/polkit-kde-authentication-agent-1";
      Restart = "on-failure";
      RestartSec = 1;
      TimeoutStopSec = 10;
    };
  };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  services.auto-cpufreq.enable = true;

  services.fwupd.enable = true;

  services.flatpak.enable = true;
  # XDG desktop portals for Flatpak
  xdg.portal.enable = true;

  # Share themes and icons with Flatpak apps
  # https://github.com/NixOS/nixpkgs/issues/119433#issuecomment-1326957279
  system.fsPackages = [ pkgs.bindfs ];
  fileSystems = let
    mkRoSymBind = path: {
      device = path;
      fsType = "fuse.bindfs";
      options = [ "ro" "resolve-symlinks" "x-gvfs-hide" ];
    };
    aggregatedFonts = pkgs.buildEnv {
      name = "system-fonts";
      paths = config.fonts.fonts;
      pathsToLink = [ "/share/fonts" ];
    };
  in {
    # Create an FHS mount to support flatpak host icons/fonts
    "/usr/share/icons" = mkRoSymBind (config.system.path + "/share/icons");
    "/usr/share/fonts" = mkRoSymBind (aggregatedFonts + "/share/fonts");
  };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  system.copySystemConfiguration = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?
}
