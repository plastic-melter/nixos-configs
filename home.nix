{ inputs, config, pkgs, lib, ... }:
{

################################################
################# HOME.NIX #####################
################################################

home = {
  stateVersion = "22.11"; # DO NOT EVER EDIT THIS
  username = "joe";
  homeDirectory = "/home/joe";
};

imports = [
  ./dotfiles/wofi
  ./dotfiles/vim
  ./dotfiles/waybar
];

home.file = {
  ".config/neofetch".source = ./dotfiles/neofetch;
  ".config/hypr".source = ./dotfiles/hypr;
  ".config/wlogout".source = ./dotfiles/wlogout;
  ".config/scripts".source = ./dotfiles/scripts;
  ".config/wallpapers".source = ./dotfiles/wallpapers;
  ".config/nwg-drawer".source = ./dotfiles/nwg-drawer;
  ".config/foot".source = ./dotfiles/foot;
};

i18n.inputMethod = {
  enable = true;
  type = "fcitx5";
  fcitx5.addons = with pkgs; [
    fcitx5-configtool
    fcitx5-mozc
    fcitx5-gtk
    fcitx5-nord
  ];
};

manual = {
  html.enable = false;
  json.enable = false;
  manpages.enable = false;
};

programs.git = {
  enable = true;
  userName = "plastic-melter";
  userEmail = "140357149+plastic-melter@users.noreply.github.com";
  extraConfig = {
    credential.helpter = "${
      pkgs.git.override { withLibsecret = true; }
    }/bin/git-credential-libsecret";
  };
};

wayland.windowManager.hyprland = {
  enable = true;
  xwayland.enable = true;
  systemd.enable = true;
  extraConfig = ''

  '';
  package = inputs.hyprland.packages.${pkgs.system}.hyprland;
  plugins = [
    #inputs.hyprland-plugins.packages.${pkgs.system}.hyprexpo
    pkgs.hyprlandPlugins.hyprexpo
  ];
};

programs.zsh = {
  enable = true;
  plugins = [
    {
      name = "powerlevel10k";
      src = pkgs.zsh-powerlevel10k;
      file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
    }
  ];
  initContent = lib.mkOrder 550 ''
    P10K_INSTANT_PROMPT="$XDG_CACHE_HOME/p10k-instant-prompt-''${(%):-%n}.zsh"
    [[ ! -r "$P10K_INSTANT_PROMPT" ]] || source "$P10K_INSTANT_PROMPT"
  '';
  localVariables = {
    POWERLEVEL9K_SHORTEN_STRATEGY = "truncate_middle";
    POWERLEVEL9K_SHORTEN_DIR_LENGHTH = "2";
    POWERLEVEL9K_PROMPT_ON_NEWLINE = false;
    POWERLEVEL9K_PROMPT_ADD_NEWLINE = false;
    #POWERLEVEL9K_PROMPT_LEFT_SEGMENT_SEPARATOR = "$'\uEB70'";
    #POWERLEVEL9K_PROMPT_RIGHT_SEGMENT_SEPARATOR = "$'\uEBF'";
    POWERLEVEL9K_LEFT_PROMPT_ELEMENTS = [
      "custom_nix"
      "dir"
    ];
    POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS = [
 #     "status"
 #     "time"
    ];
    POWERLEVEL9K_CUSTOM_NIX = "echo 󱄅";
    POWERLEVEL9K_CUSTOM_NIX_FOREGROUND = "014";
    POWERLEVEL9K_CUSTOM_NIX_BACKGROUND = "239";
    POWERLEVEL9K_DIR_FOREGROUND = "219";
    POWERLEVEL9K_DIR_BACKGROUND = "000";
    POWERLEVEL9K_STATUS_OK_FOREGROUND = "046";
    POWERLEVEL9K_STATUS_OK_BACKGROUND = "000";
    POWERLEVEL9K_STATUS_ERROR_FOREGROUND = "203";
    POWERLEVEL9K_STATUS_ERROR_BACKGROUND = "000";
    POWERLEVEL9K_TIME_FOREGROUND = "105";
    POWERLEVEL9K_TIME_BACKGROUND = "233";
    EDITOR = "vi";
  };
  #alias
  shellAliases = {
    games = "ranger /home/joe/Backups/Games/quick-access";
    gens = "sudo nix-env --list-generations --profile /nix/var/nix/profiles/system";
    megayeet = "/etc/nixos/dotfiles/scripts/megayeet.sh";
    elona = "wine /home/joe/Backups/Games/quick-access/elona/elonaplus2.24fix/elonaplus.exe";
    sudo = "doas";
    fetch = "fastfetch";
    sys = "doas vim /etc/nixos/configuration.nix";
    home = "vim /etc/nixos/home.nix";
    flake = "doas vim /etc/nixos/flake.nix";
    dots = "ranger /etc/nixos/dotfiles";
    scripts = "ranger /etc/nixos/dotfiles/scripts";
    clc = "clear";
    range = "ranger";
    rranger = "ranger";
    kms = "/etc/nixos/dotfiles/scripts/kms.sh";
    kys = "pkill";
    yeet = "doas nixos-rebuild switch --flake /etc/nixos";
    notes = "vim ~/.notes.md";
    colors = "vim /etc/nixos/dotfiles/colors";
    lowres = "hyprctl keyword monitor eDP-1,1680x1050,0x0,1 && hyprctl keyword monitor HDMI-A-1,1920x1080,1680x0,1";
    highres = "hyprctl keyword monitor eDP-1,2560x1600,0x0,1 && hyprctl keyword monitor HDMI-A-1,3840x2160,2560x0,1";
    homeclean = "env --chdir=/home/joe /etc/nixos/dotfiles/scripts/homeclean.sh";
  };
};

dconf.settings = {
  "org/virt-manager/virt-manager/connections" = {
    autoconnect = ["qemu:///system"];
    uris = ["qemu:///system"];
  };
  "org/gnome/desktop/interface" = {
    color-scheme = "prefer-dark";
  };
};

services.dunst = {
  enable = true;
  package = pkgs.dunst;
  #iconTheme.package = 
  #iconTheme = 
  #iconTheme.name =
  #iconTheme.size =
  #waylandDisplay = 
  settings = {
    global = {
      timeout = 2;
      width = "(0, 600)";
      height = 200;
      offset = "0x30";
      origin = "top-center";
      corner_radius = 15;
      notification_limit = 5;
      idle_threshold = 0;
      progress_bar = true;
      progress_bar_height = 15;
      progress_bar_horizontal_alignment = "center";
      progress_bar_corner_radius = 3;
      progress_bar_min_width = 150;
      progress_bar_max_width = 350;
      progress_bar_frame_width = 2;
      separator_height = 3;
      separator_color = "auto";
      sort = "false";
      layer = "overlay";
      line_height = 0;
      format = "<b>%s</b>\n%b";
      padding = 5;
      horizontal_padding = 5;
      icon_corner_radius = 5;
      text_icon_padding = 5;
      frame_width = 4;
      frame_color = "#D697CF";
      background_color = "#181b28";
      foreground_color = "#ffffd8";
      font = "NotoSansCJK 18";
      min_icon_size = 128;
      max_icon_size = 128;
      layerrule = "blur, notifications";
      #layerrule = "ignorealpha 0.8, notifications";
      background = "#090909B5";
    };
  };
};

services.playerctld.enable = true;

xdg.desktopEntries = {
  seihou1 = {
    name = "西方1";
    genericName = "seihou1";
    exec = "wine /home/joe/Backups/Games/quick-access/Seihou1/seihou1.exe";
    icon = "/etc/nixos/dotfiles/images/seihou1.jpg";
    terminal = false;
    categories = [ "Game" ];
    comment = "秋霜玉 (Shuusou Gyoku)";
    type = "Application";
  };
  seihou2 = {
    name = "西方2";
    genericName = "seihou2";
    exec = "wine /home/joe/Backups/Games/quick-access/Seihou2/seihou2.exe";
    icon = "/etc/nixos/dotfiles/images/seihou2.jpg";
    terminal = false;
    categories = [ "Game" ];
    comment = "稀翁玉 (Kioh Gyoku)";
    type = "Application";
  };
  seihou3 = {
    name = "西方3";
    genericName = "seihou3";
    exec = "wine /home/joe/Backups/Games/quick-access/Seihou3/seihou3.exe";
    icon = "/etc/nixos/dotfiles/images/seihou3.jpg";
    terminal = false;
    categories = [ "Game" ];
    comment = "幡紫竜 (Banshiryuu)";
    type = "Application";
  };
  th06 = {
    name = "東方06";
    genericName = "th06";
    exec = "wine /home/joe/Backups/Games/quick-access/th06/th06english/th06e.exe";
    icon = "/etc/nixos/dotfiles/images/th6.png";
    terminal = false;
    categories = [ "Game" ];
    comment = "Embodiment of Scarlet Devil";
    type = "Application";
  };
  th07 = {
    name = "東方07";
    genericName = "th07";
    exec = "wine /home/joe/Backups/Games/quick-access/th07/th07/th07patched.exe";
    icon = "/etc/nixos/dotfiles/images/th7.png";
    terminal = false;
    categories = [ "Game" ];
    comment = "Perfect Cherry Blossom";
    type = "Application";
  };
  th075 = {
    name = "東方07.5";
    genericName = "th07.5";
    exec = "wine /home/joe/Backups/Games/quick-access/th07.5/th07.5/th075.exe";
    icon = "/etc/nixos/dotfiles/images/th7.5.png";
    terminal = false;
    categories = [ "Game" ];
    comment = "Immaterial and Missing Power";
    type = "Application";
  };
  th08 = {
    name = "東方08";
    genericName = "th08";
    exec = "wine /home/joe/Backups/Games/quick-access/th08/th08/th08.exe";
    icon = "/etc/nixos/dotfiles/images/th8.png";
    terminal = false;
    categories = [ "Game" ];
    comment = "Imperishable Night";
    type = "Application";
  };
  th09 = {
    name = "東方09";
    genericName = "th09";
    exec = "wine /home/joe/Backups/Games/quick-access/th09/th09/th09.exe";
    icon = "/etc/nixos/dotfiles/images/th9.png";
    terminal = false;
    categories = [ "Game" ];
    comment = "Phantasmagoria of Flower View";
    type = "Application";
  };
  th095 = {
    name = "東方09.5";
    genericName = "th09.5";
    exec = "wine /home/joe/Backups/Games/quick-access/th09.5/th09.5/th095.exe";
    icon = "/etc/nixos/dotfiles/images/th9.5.png";
    terminal = false;
    categories = [ "Game" ];
    comment = "Shoot the Bullet";
    type = "Application";
  };
  th10 = {
    name = "東方10";
    genericName = "th10";
    exec = "wine /home/joe/Backups/Games/quick-access/th10/th10/th10.exe";
    icon = "/etc/nixos/dotfiles/images/th10.png";
    terminal = false;
    categories = [ "Game" ];
    comment = "Mountain of Faith";
    type = "Application";
  };
  th105 = {
    name = "東方10.5";
    genericName = "th10.5";
    exec = "wine /home/joe/Backups/Games/quick-access/th10.5/th10.5/th105.exe";
    icon = "/etc/nixos/dotfiles/images/th10.5.png";
    terminal = false;
    categories = [ "Game" ];
    comment = "Scarlet Weather Rhapsody";
    type = "Application";
  };
  th11 = {
    name = "東方11";
    genericName = "th11";
    exec = "wine /home/joe/Backups/Games/quick-access/th11/th11/th11.exe";
    icon = "/etc/nixos/dotfiles/images/th11.png";
    terminal = false;
    categories = [ "Game" ];
    comment = "Subterranean Animism";
    type = "Application";
  };
  th12 = {
    name = "東方12";
    genericName = "th12";
    exec = "wine /home/joe/Backups/Games/quick-access/th12/th12/th12.exe";
    icon = "/etc/nixos/dotfiles/images/th12.png";
    terminal = false;
    categories = [ "Game" ];
    comment = "Undefined Fantastic Object";
    type = "Application";
  };
  th123 = {
    name = "東方12.3";
    genericName = "th12.3";
    exec = "wine /home/joe/Backups/Games/quick-access/th12.3/th12.3/th123.exe";
    icon = "/etc/nixos/dotfiles/images/th12.3.jpg";
    terminal = false;
    categories = [ "Game" ];
    comment = "Hisoutensoku";
    type = "Application";
  };
  th125 = {
    name = "東方12.5";
    genericName = "th12.5";
    exec = "wine /home/joe/Backups/Games/quick-access/th12.5/th12.5/th125.exe";
    icon = "/etc/nixos/dotfiles/images/th12.5.png";
    terminal = false;
    categories = [ "Game" ];
    comment = "Double Spoiler";
    type = "Application";
  };
  th128 = {
    name = "東方12.8";
    genericName = "th12.8";
    exec = "wine /home/joe/Backups/Games/quick-access/th12.8/th12.8/th128.exe";
    icon = "/etc/nixos/dotfiles/images/th12.8.png";
    terminal = false;
    categories = [ "Game" ];
    comment = "Fairy Wars";
    type = "Application";
  };
  th13 = {
    name = "東方13";
    genericName = "th13";
    exec = "wine /home/joe/Backups/Games/quick-access/th13/th13/th13.exe";
    icon = "/etc/nixos/dotfiles/images/th13.png";
    terminal = false;
    categories = [ "Game" ];
    comment = "Ten Desires";
    type = "Application";
  };
  th135 = {
    name = "東方13.5";
    genericName = "th13.5";
    exec = "wine /home/joe/Backups/Games/quick-access/th13.5/th13.5/th135.exe";
    icon = "/etc/nixos/dotfiles/images/th13.5.jpg";
    terminal = false;
    categories = [ "Game" ];
    comment = "Hopeless Masquerade";
    type = "Application";
  };
  th14 = {
    name = "東方14";
    genericName = "th14";
    exec = "wine /home/joe/Backups/Games/quick-access/th14/th14/th14.exe";
    icon = "/etc/nixos/dotfiles/images/th14.jpg";
    terminal = false;
    categories = [ "Game" ];
    comment = "Double Dealing Character";
    type = "Application";
  };
  th143 = {
    name = "東方14.3";
    genericName = "th14.3";
    exec = "wine /home/joe/Backups/Games/quick-access/th14.3/th14.3/th143.exe";
    icon = "/etc/nixos/dotfiles/images/th14.3.jpg";
    terminal = false;
    categories = [ "Game" ];
    comment = "Impossible Spell Card";
    type = "Application";
  };
  th145 = {
    name = "東方14.5";
    genericName = "th14.5";
    exec = "wine /home/joe/Backups/Games/quick-access/th14.5/th14.5/th145.exe";
    icon = "/etc/nixos/dotfiles/images/th14.5.jpg";
    terminal = false;
    categories = [ "Game" ];
    comment = "Urban Legend in Limbo";
    type = "Application";
  };
  th15 = {
    name = "東方15";
    genericName = "th15";
    exec = "wine /home/joe/Backups/Games/quick-access/th15/th15/th15.exe";
    icon = "/etc/nixos/dotfiles/images/th15.png";
    terminal = false;
    categories = [ "Game" ];
    comment = "Legacy of Lunatic Kingdom";
    type = "Application";
  };
  th155 = {
    name = "東方15.5";
    genericName = "th15.5";
    exec = "wine /home/joe/Backups/Games/quick-access/th15.5/th15.5/th155.exe";
    icon = "/etc/nixos/dotfiles/images/th15.5.jpg";
    terminal = false;
    categories = [ "Game" ];
    comment = "Antimony of Common Flowers";
    type = "Application";
  };
  th16 = {
    name = "東方16";
    genericName = "th16";
    exec = "wine /home/joe/Backups/Games/quick-access/th16/th16/th16/th16.exe";
    icon = "/etc/nixos/dotfiles/images/th16.png";
    terminal = false;
    categories = [ "Game" ];
    comment = "Hidden Star in Four Seasons";
    type = "Application";
  };
  th165 = {
    name = "東方16.5";
    genericName = "th16.5";
    exec = "wine /home/joe/Backups/Games/quick-access/th16.5/th16.5/th165.exe";
    icon = "/etc/nixos/dotfiles/images/th16.5.jpg";
    terminal = false;
    categories = [ "Game" ];
    comment = "Violet Detector";
    type = "Application";
  };
  th17 = {
    name = "東方17";
    genericName = "th17";
    exec = "wine /home/joe/Backups/Games/quick-access/th17/th17/th17.exe";
    icon = "/etc/nixos/dotfiles/images/th17.png";
    terminal = false;
    categories = [ "Game" ];
    comment = "Wily Beast and Weakest Creature";
    type = "Application";
  };
  th175 = {
    name = "東方17.5";
    genericName = "th17.5";
    exec = "wine /home/joe/Backups/Games/quick-access/th17.5/th17.5/game.exe";
    icon = "/etc/nixos/dotfiles/images/th17.5.jpg";
    terminal = false;
    categories = [ "Game" ];
    comment = "Sunken Fossil World";
    type = "Application";
  };
  th18 = {
    name = "東方18";
    genericName = "th18";
    exec = "wine /home/joe/Backups/Games/quick-access/th18/th18/th18.exe";
    icon = "/etc/nixos/dotfiles/images/th18.jpg";
    terminal = false;
    categories = [ "Game" ];
    comment = "Unconnected Marketeers";
    type = "Application";
  };
  th185 = {
    name = "東方18.5";
    genericName = "th18.5";
    exec = "wine /home/joe/Backups/Games/quick-access/th18.5/th18.5/th185.exe";
    icon = "/etc/nixos/dotfiles/images/th18.5.png";
    terminal = false;
    categories = [ "Game" ];
    comment = "100th Black Market";
    type = "Application";
  };
  th19 = {
    name = "東方19";
    genericName = "th19";
    exec = "wine /home/joe/Backups/Games/quick-access/th19/th19/th19.exe";
    icon = "/etc/nixos/dotfiles/images/th19.png";
    terminal = false;
    categories = [ "Game" ];
    comment = "Unfinished Dream of All Living Ghost";
    type = "Application";
  };
  exceed3rd = {
    name = "eXceed 3rd - Black Package";
    genericName = "eXceed3";
    exec = "wine /home/joe/Backups/Games/quick-access/exceed3bp/eXceed3rd-BR.exe";
    icon = "/etc/nixos/dotfiles/images/exceed3.png";
    terminal = false;
    comment = "eXeed 3d - JADE PENETRATE - BLACK PACKAGE";
    type = "Application";
    categories = [ "Game" ];
  };
  brda = {
    name = "Blue Revolver";
    genericName = "BRDA";
    exec = "/etc/nixos/dotfiles/scripts/BRDA.sh";
    icon = "/home/joe/Backups/Games/quick-access/BRDA/Blue.Revolver.v1.52/Blue.Revolver.v1.52/Soundtrack/mp3/Cover.jpg";
    terminal = false;
    categories = [ "Game" ];
    comment = "DRM-free copy!";
    type = "Application";
  };
  hyprpicker = {
    name = "hyprpicker";
    genericName = "color-picker";
    exec = "foot -e hyprpicker";
    icon = "/etc/nixos/dotfiles/images/picker.png";
    terminal = true;
    categories = [ "Utility" ];
    comment = "Color picker tool from hyprwm";
    type = "Application";
  };
  radeontop = {
    name = "GPU Monitor";
    genericName = "radeontop";
    exec = "foot -e radeontop";
    icon = "/etc/nixos/dotfiles/images/gpu.png";
    terminal = false;
    categories = [ "Utility" ];
    comment = "Radeon GPU monitor (TUI)";
    type = "Application";
  };
  zenmonitor = {
    name = "Zenmonitor"; 
    icon = "/etc/nixos/dotfiles/images/amd.png";
    exec = "zenmonitor";
    categories = [ "Utility" ];
    type = "Application";
  };
  ranger = {
    name = "ranger";
    genericName = "ranger";
    exec = "foot -e ranger";
    icon = "/etc/nixos/dotfiles/images/folder.png";
    terminal = false;
    categories = [ "Utility" ];
    comment = "TUI File Manager";
    type = "Application";
  }; 
  pavucontrol = {
    name = "Pavucontrol";
    exec = "pavucontrol";
    icon = "/etc/nixos/dotfiles/images/mixer.png";
    terminal = false;
    categories = [ "Utility" ];
    comment = "Pulseaudio volume control / mixer";
    type = "Application";
  }; 
  qt5ct = {
    name = "qt5 config tool";
    exec = "qt5ct";
    icon = "/etc/nixos/dotfiles/images/qtlogo.png";
    terminal = false;
    categories = [ "Utility" ];
    comment = "GUI configuration tool for qt5";
    type = "Application";
  }; 
  qt6ct = {
    name = "qt6 config tool";
    exec = "qt6ct";
    icon = "/etc/nixos/dotfiles/images/qtlogo.png";
    terminal = false;
    categories = [ "Utility" ];
    comment = "GUI configuration tool for qt6";
    type = "Application";
  }; 
  htop = {
    name = "htop";
    exec = "foot -w 1500x750-e htop";
    icon = "/etc/nixos/dotfiles/images/htop.png";
  };
############### HIDDEN ##################
  footclient = {
    name = "Foot Client";
    noDisplay = true;
    settings = {
      Hidden = "true";
    };
  };
  footserver = {
    name = "Foot Server";
    noDisplay = true;
    settings = {
      Hidden = "true";
    };
  };
  protontricks = {
    name = "Protontricks";
    noDisplay = true;
    settings = {
      Hidden = "true";
    };
  };
  kbd-layout-viewer5 = {
    name = "Keyboard layout viewer";
    noDisplay = true;
    settings = {
      Hidden = "true";
    };
  };
  kvantum = {
    name = "kvantum";
    noDisplay = true;
    settings = {
      Hidden = "true";
    };
  };
  xterm = {
    name = "XTerm";
    noDisplay = true;
    settings = {
      Hidden = "true";
    };
  };
  android-file-transfer = {
    name = "Android File Transfer";
    noDisplay = true;
    settings = {
      Hidden = "true";
    };
  };
};

systemd.user.sessionVariables = {
  GTK_THEME = "Arc-Dark";
  XDG_ICON_FALLBACK = "/etc/nixos/dotfiles/images/blankicon.png";
  OPENAI_API_KEY = "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";
  QT_QPA_PLATFORM = "wayland";
  QT_QPA_PLATFORMTHEME = "qt5ct";
  SDL_VIDEODRIVER = "wayland";
  XDG_SESSION_TYPE = "wayland";
  GTK_USE_PORTAL = "0";
  XMODIFIERS = "@im=fcitx";
  GTK_IM_MODULE="=fcitx";
  QT_IM_MODULE="=fcitx";
  LIBINPUT_ATTR_TRACKPOINT_ACCEL = "0.5";
};

systemd.user.targets.tray = {
  Unit = {
    Description = "Home Manager System Tray";
    Requires = [ "graphical-session-pre.target" ];
  };
};

programs = { 
  foot.enable = true;
  obs-studio = {
    enable = true;
  };
};

home.packages = with pkgs; [
# apps
  audacious                 # music player
  bluetooth_battery         # fetch info form BT devices
  cdrdao                    # burn files to CDs
  cmus                      # TUI music player
  deadbeef                  # music player
  dolphin-emu-beta          # latest testing ver
  eww                       # wacky widgets
  file                      # determine file type
  firefox-wayland           # web browser
  ffmpeg                    # CLI video tool
  gimp                      # image edit suite
  gnome-bluetooth           # GUI for bluetooth
  hyprpicker                # color picker tool
  imagemagick               # image conv tool
  kdePackages.kcolorchooser # hex color tool
  kdePackages.kdenlive      # video editor
  libreoffice-fresh         # latest stable ver
  lutris                    # game manager
  mupdf                     # pdf viewer
  pamixer                   # pulseaudio tool
  pavucontrol               # pulse gui tool
  playerctl                 # utility, supports many
  protontricks              # proton extras
  prusa-slicer              # Prusa's slicer
  qbittorrent               # torrent client
  qalculate-qt              # gui calculator
  qalculate-gtk             # gui calculator
  spotify                   # electron client
  tagainijisho              # JP dictionary
  vlc                       # media player
  wev                       # identify keysyms
  wl-clipboard              # wayland copy-paste
  wf-recorder               # wlroots screen recorder
  xmlstarlet                # modify xml files or something
  zathura                   # document viewer
  zsh-powerlevel10k         # neat ZSH prompt
  zoom-us                   # shit software
];

qt = {
  enable = true;
  platformTheme.name = "qt5ct";
  style.package = pkgs.adwaita-qt;
  style.name = "adwaita-dark";
};

gtk = {
  enable = true;
  theme = {
    name = "Adwaita-dark";
    package = pkgs.gnome-themes-extra;
  };
};

################################################
}           # END OF HOME.NIX # 
################################################
