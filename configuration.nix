{ inputs, outputs, lib, config, pkgs, ... }: 

#############################################
############ X13 G3 AMD CONFIG ##############
#############################################

let pkgs-unstable = inputs.hyprland.inputs.nixpkgs.legacyPackages.${pkgs.stdenv.hostPlatform.system}; in { 

nix = {
  package = pkgs.nixVersions.latest;
  extraOptions = ''
    experimental-features = nix-command flakes
  '';
  settings = {
    trusted-users = [ "root" "joe" ];
    substituters = ["https://hyprland.cachix.org"];
    trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
  };
};

imports = [
  ./hardware-configuration.nix
  ./cachix.nix
];

nixpkgs.config = {
  allowUnfree = true;
  allowBroken = false;
};

programs = {
  zsh.enable = true;
  dconf.enable = true;
  steam.enable = true;
  seahorse.enable = true;
  adb.enable = true;
  gamescope.enable = true;
  xwayland.enable = true;
  ydotool.enable = true;
  hyprland = {
    enable = true;
    portalPackage = pkgs.xdg-desktop-portal-hyprland;
  };
  wayfire = {
    enable = true;
    xwayland.enable = true;
    plugins = with pkgs.wayfirePlugins; [
      wcm
      wayfire-plugins-extra
    ];
  };
};

boot = {
  kernelPackages = pkgs.linuxPackages_latest;
  blacklistedKernelModules = [ "k10temp" ];
  kernelParams = [ "amd-pstate=passive" "acpi_osi=Linux" ];
  kernelModules = [ "zenpower" ];
  loader.grub = {
    enable = true;
    device = "nodev";
    useOSProber = true;
    enableCryptodisk = true;
    efiSupport = true;
    default = "2";
    extraConfig = ''
      timeout=-1
      GRUB_GFXMODE=2560x1600x128,auto
      menuentry "Reboot" {
        reboot
      }
      menuentry "Poweroff" {
        halt
      }
    '';
  };
  loader.efi.canTouchEfiVariables = true;
  loader.grub.theme = pkgs.stdenv.mkDerivation {
    pname = "distro-grub-themes";
    version = "3.1";
    src = pkgs.fetchFromGitHub {
      owner = "AdisonCavani";
      repo = "distro-grub-themes";
      rev = "v3.1";
      hash = "sha256-ZcoGbbOMDDwjLhsvs77C7G7vINQnprdfI37a9ccrmPs=";
    };
    installPhase = "cp -r customize/thinkpad $out";
  };
};

swapDevices = [{device = "/swapfile"; size = 50000;}];

security = {
  rtkit.enable = true;
  pam.services.hyprland.enableGnomeKeyring = true;
};

virtualisation.libvirtd.enable = true;

networking = {
  hostName = "nix13";
  networkmanager.enable = true;
  useDHCP = false;
  interfaces.wlp1s0.useDHCP = true;
}; 

time.timeZone = "America/Los_Angeles";

i18n = {
  defaultLocale = "ja_JP.UTF-8";
  inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5.addons = with pkgs; [
      fcitx5-configtool
      fcitx5-mozc
      fcitx5-gtk
      fcitx5-nord
    ];
  };
};

console = {
  font = "Lat2-Terminus16";
  keyMap = "jp106";
};

fonts = {
  packages = [ pkgs.carlito pkgs.dejavu_fonts pkgs.ipafont pkgs.kochi-substitute pkgs.liberation_ttf pkgs.nerd-fonts.symbols-only pkgs.noto-fonts-cjk-sans pkgs.source-code-pro pkgs.ttf_bitstream_vera ];
  fontconfig.defaultFonts = {
    monospace = [
      "DejaVu Sans Mono"
      "IPAGothic"
    ];
    sansSerif = [
      "DejaVu Sans"
      "IPAPGothic"
    ];
    serif = [
      "DejaVu Serif"
      "IPAPMincho"
    ];
  };
};

environment.variables = {
  QT_QPA_PLATFORMTHEME = "qt5ct";
  XDG_ICON_FALLBACK = "/etc/nixos/dotfiles/images/blankicon.png";
};

nixpkgs.config.qt5 = {
  enable = true;
  platformTheme = "qt5ct";
  #style = {
  #  package = pkgs.adwaita-qt;
  #  name = "adwaita-dark";
  #};
};

services = {
  xserver = {
    videoDrivers = [ "amdgpu" ];
    enable = true;
    xkb.layout = "jp";
    xkb.model = "pc106";
    desktopManager.runXdgAutostartIfNone = true;
  };
  libinput = {
    enable = true;
    touchpad.disableWhileTyping = true;
    touchpad.naturalScrolling = true;
  };
  fstrim.enable = true;
  fwupd.enable = true;
  tlp.enable = true;
  tlp.settings = { 
    START_CHARGE_THRESH_BAT0 = 90; 
    STOP_CHARGE_THRESH_BAT0 = 92; 
  };
  openssh.enable = true;
  udev.extraRules = ''
  SUBSYSTEM=="usb", ATTR{idVendor}=="18d1", MODE="0666", GROUP="plugdev"
  '';
  printing.enable = true;
  gnome.gnome-keyring.enable = true;
  blueman.enable = true;
  #pulseaudio.enable = false;
  pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    extraConfig.pipewire = {
      "client" = {
        "context.clock.rate" = 48000;
        "context.clock.allowed-rates" = [ 44100 48000 ];
        "context.clock.quantum" = 2048;
      };
    };
    extraConfig.pipewire-pulse = {
      "pulse" = {
        "default-sample-rate" = 44100;
      };
    };
  };
  displayManager = {
    sddm = {
      enable = true;
      wayland.enable = true;
      theme = "catppuccin-mocha";
      package = pkgs.kdePackages.sddm;
    };
    sessionPackages = [ pkgs.hyprland ];
    defaultSession = "hyprland";
    autoLogin = {
      enable = true;
      user = "joe";
    };
  };
};

powerManagement = {
 cpufreq = {
    min = 800000;
    max = 4770000;
  };
  cpuFreqGovernor = "ondemand";
};

hardware = {
  cpu.amd = {
    updateMicrocode = true;
  };
  bluetooth.enable = true;
  graphics = {
    enable = true;
    enable32Bit = true;
    #package = pkgs-unstable.mesa.drivers;
    #package32 = pkgs-unstable.pkgsi686Linux.mesa.drivers;
  };
  enableAllFirmware = true;
  trackpoint = {
    emulateWheel = true;
    speed = 97; # 97 default
    sensitivity = 128; # 128 default
  };
};

xdg.portal = {
  enable = true;
  extraPortals = with pkgs; [xdg-desktop-portal-gtk];
};

programs.neovim = {
  enable = true;
  package = pkgs.neovim-unwrapped;
  viAlias = true;
  vimAlias = true;
  configure = {
    customRC = ''
      set clipboard^=unnamed,unnamedplus
      set number
      set ignorecase
      set mouse=v
      set hlsearch
      set incsearch
      set tabstop=2
      set softtabstop=2
      set expandtab
      set autoindent
      syntax on
    '';
  };
};

security = {
  polkit.enable = true;
  sudo.enable = false;
  doas = {
    enable = true;
    wheelNeedsPassword = false;
    extraRules = [{
      groups = [ "doas" ];
      noPass = true;
      keepEnv = true;
      users = [ "joe" ];
    }];
  };
};

users = {
  defaultUserShell = pkgs.zsh;
  users.joe = {
    isNormalUser = true;
    extraGroups = [ "adbusers" "dialout" "libvirtd" "audio" "disk" "video" "power" "plugdev" "network" "wheel" "uinput" ];
  };
}; 

environment.systemPackages = with pkgs; [
  # apps
  acpid					# watch acpi events
  adwaita-icon-theme			# icon theme
  adwaita-qt				# qt theme
  adwaita-qt6				# qt theme
  android-file-transfer			# android stuff
  android-tools				# android stuff
  android-udev-rules			# non-root users can use adb
  appimage-run				# run appimages
  bash					# shell
  bc					# do math in bash
  bison					# idk
  brightnessctl				# brightness control
  btop					# htop but better
  cachix				# prebuilt binaries
  catppuccin-sddm			# sddm theme
  cpufrequtils				# check CPU stats
  curl					# download stuff
  dislocker				# unluck Bitlocker
  dracula-icon-theme			# gtk icon theme
  dracula-theme				# gtk theme
  fastfetch				# fetch
  firestarter				# explode hardware
  flex					# idk
  git					# git
  guestfs-tools				# for mounting Windows .vhdx backups
  htop					# sys mon tool
  hyprdim				# auto dim inactive windows in hyprland
  hypridle				# idle daemon
  hyprland-workspaces			# workspace widget
  hyprlock				# screen locker
  hyprnome				# gnome-like window switching
  hyprpaper				# wayland wallpapers
  hyprpicker				# color picker tool
  hyprshot				# screenshot tool
  id3v2					# mp3 metadata
  imv					# image viewer
  iotop					# view IO stats
  jmtpfs				# xfer files w/ android
  killall				# kill processes
  libarchive				# gives bsdtar
  libguestfs-with-appliance		# mount Win10 .vhdx backups
  libnotify				# notify-send
  libsForQt5.polkit-kde-agent		# privilidge toolbox
  libsForQt5.qt5ct			# make Qt work on Wayland
  libsForQt5.qtstyleplugin-kvantum	# qt stuff
  libgdiplus				# might help 2hu FDF run...?
  libsixel				# terminal images
  libmtp				# for mounting Android
  light					# backlight control
  linuxKernel.packages.linux_6_1.cpupower	# cpu util
  lm_sensors				# HW sensors
  lounge-gtk-theme			# gtk theme
  lshw					# HW tool
  lsix					# sixel command
  mission-center			# GUI resource monitor
  moreutils				# more utilities. duh.
  mtpfs					# android mount
  neofetch				# fetch
  nixos-option				# gives info about nixos options
  networkmanagerapplet			# tray thing for network manager
  ntfs3g				# work with NTFS
  nwg-launchers				# cool wayland launcher
  nwg-drawer				# nwg-grid but better
  openssl				# ssl/tls library
  p7zip					# compression tool
  pciutils				# useful
  poppler_utils				# PDF tools
  powertop				# power monitor
  protontricks				# for windows games
  qt6Packages.qtstyleplugin-kvantum	# qt thing
  radeontop				# AMD GPU monitor
  ranger				# TUI file browser
  rpi-imager				# rpi tool
  rsync					# sync tool
  simple-mtpfs				# mount android phone
  s-tui					# stress tool
  stress				# stress tool
  swaylock				# wayland screen locker
  swww					# wayland wallpapers
  tmux					# terminal multiplexer
  unrar-wrapper				# deal with rar files
  unzip					# deal with zip files
  usbutils				# handy tools
  vim					# text editor
  virt-manager				# better than virtualbox
  w3m					# TUI web browser / terminal images
  waybar				# status bar
  waypaper				# GUI wallpaper manager
  wdisplays				# like arandr but wayland
  webcord				# discord client that plays nice with Wayland
  wineWowPackages.waylandFull		# WINE
  winetricks				# more WINE
  wlogout				# gui logout menu
  wlr-randr				# like xrandr but wayland
  wget					# download stuff
  xdotool				# send kb/mouse events
  xfce.thunar				# GUI file manager
  zenmonitor				# AMD HW monitor

  (catppuccin-sddm.override {
    flavor = "mocha";
    font  = "Noto Sans";
    fontSize = "9";
    background = "/etc/nixos/dotfiles/wallpapers/blue-moon-5k.jpg";
    loginBackground = true;
  })
];

################################################
########## DO NOT EVER CHANGE THIS #############
################################################
system.stateVersion = "22.11";##################
################################################
}########## END OF CONF.NIX # ##################
################################################
