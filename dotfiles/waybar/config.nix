{ config, pkgs, lib, osConfig, ...}: {
mainBar = {
  position = "top";
  layer = "top";
  height = 46;
  margin-top = 1;
  margin-bottom = 0;
  margin-left = 0;
  margin-right = 0;
  modules-left = [
    #"custom/launcher" 
    "tray"
    "clock"
    "pulseaudio"
    "backlight"
    "network"
    "custom/playerstatus"
  ];
  modules-center = [
    "wlr/taskbar"
  ];
  modules-right = [
    "cpu"
    #"custom/amdpower"
    "custom/cooling"
    "memory"
    "custom/diskuse"
    "custom/energy"
    "battery"
#    "hyprland/workspaces"
  ];

  clock = {
    format = "   {:%H:%M}";
    tooltip = "true";
    tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
    format-alt = "   {:%Y-%m-%d}";
  };

  "hyprland/workspaces" = {
    active-only = false;
    all-outputs = true;
    persistent_workspaces  = {
      "1"  = "[]";
      "2"  = "[]";
      "3"  = "[]";
      "4"  = "[]";
      "5"  = "[]";
    };
    disable-scroll = false;
    on-scroll-up = "hyprctl dispatch workspace e-1";
    on-scroll-down = "hyprctl dispatch workspace e+1";
    #format = "{icon}";
    #on-click = "activate";
    format-icons = {
      "1" = "󱄅";
      "2" = "󱄅";
      "3" = "󱄅";
      "4" = "󱄅";
      "5" = "󱄅";
      "active" = "󱄅";
      "urgent" = "󱄅";
      "default" = "󱄅";
    };
    sort-by-number = true;
  };

  "wlr/taskbar" = {
    format = "{icon}";
    icon-size = 36;
    #icon-theme =
    all-outputs = false;
    tooltip-format = "{title}";
    on-click = "activate";
    active-first = false;
  };

  "custom/playerctl" = {
    format = "{icon}";
    return-type = "json";
    max-length = 64;
    exec = "playerctl -a metadata --format '{\"text\": \"{{artist}} - {{markup_escape(title)}}\", \"tooltip\": \"{{playerName}} : {{markup_escape(title)}}\", \"alt\": \"{{status}}\", \"class\": \"{{status}}\"}' -F";
    on-click-middle = "playerctl play-pause";
    on-click = "playerctl previous";
    on-click-right = "playerctl next";
    format-icons = {
      Playing = "<span foreground ='#6791eb'>󰐌 </span>";
      Paused = "<span foreground ='#cdd6f4'>󰏥 </span>";
    };
    tooltip = false;
  };

  "custom/audiodeets" = {
    format = "<span>󰝚  {}</span>";
    return-type = "json";
    max-length = 48;
    exec = "playerctl -a metadata --format '{\"text\": \"{{artist}} - {{markup_escape(title)}}\", \"tooltip\": \"{{playerName}} : {{markup_escape(title)}}\", \"alt\": \"{{status}}\", \"class\": \"{{status}}\"}' -F";
    on-click-middle = "playerctl play-pause";
    on-click = "playerctl previous";
    on-click-right = "playerctl next";
    format-icons = {
      Playing = "<span foreground ='#6791eb'>󰐌 </span>";
      Paused = "<span foreground ='#cdd6f4'>󰏥 </span>";
    };
    tooltip = false;
  };
    

  "custom/playerlabel" = {
    format = "<span>󰝚  {}</span>";
    return-type = "json";
    max-length = 48;
    exec = "playerctl -a metadata --format '{\"text\": \"{{artist}} - {{markup_escape(title)}}\", \"tooltip\": \"{{playerName}} : {{markup_escape(title)}}\", \"alt\": \"{{status}}\", \"class\": \"{{status}}\"}' -F";
    on-click-middle = "playerctl play-pause";
    on-click = "playerctl previous";
    on-click-right = "playerctl next";
    format-icons = {
      Playing = "<span foreground ='#6791eb'>󰐌 </span>";
      Paused = "<span foreground ='#cdd6f4'>󰏥 </span>";
    };
    tooltip = false;
  };

  battery = {
    states = {
      good = 90;
      warning = 30;
      critical = 15;
    };
    format ="{icon}  {capacity}%";
    format-charging = "  {capacity}%";
    format-plugged = "  {capacity}%";
    format-alt = "{icon} {time}";
    format-icons = ["  " "  " "  " "  " "  "];
  };

  memory = {
    format = "󰍛  {percentage}%";
    tooltip-format = "RAM: {used} / {total} GiB | SWAP: {swapUsed} / {swapTotal} GiB";
    format-alt = "{used} / {total} GiB | {swapUsed} / {swapTotal} GiB";
    tooltip  = "true";
    interval = 5;
  };

  cpu = {
    format = "  {usage}%";
    format-alt = "  {avg_frequency} GHz";
    interval = 5;
  };

  "custom/diskuse" = {
    format = "󰋊  {}";
    exec = "/etc/nixos/dotfiles/scripts/diskuse.sh";
    interval = 1;
  };
  
  network = {
    format-wifi = "󰤨  {essid}";
    format-ethernet = "󰈀  {ifname}";
    format-linked = "󰈀  {ifname} (No IP)";
    format-disconnected = "󰤭";
    format-alt = "󰜷 {bandwidthUpBytes}  󰜮 {bandwidthDownBytes}";
    tooltip-format = "{ifname}: {ipaddr}/{cidr}";
  };

  tray = {
    icon-size = 28;
    spacing = 5;
  };

  backlight = {
    # "device" = "acpi_video1";
    format = "{icon}  {percent}%";
    format-icons = ["" "" "" "" "" "" "" "" ""];
    #  "on-scroll-up" =;
    #  "on-scroll-down" =;
  };
    tooltip-format = "";

  pulseaudio = {
    format = "󰕾  {volume}%";
    format-muted = "󰝟";
    on-click = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";  
    on-right-click = "pavucontrol";
    scroll-step = 5;
  };
  "custom/randwall" = {
    format = "󰏘";
    on-click = "bash $HOME/.config/hypr/randwall.sh";
    on-click-right = "bash $HOME/.config/hypr/wall.sh";
  };
  "custom/launcher" = {
    format = "";
    on-click = "nwggrid -o 0.8";
    tooltip = false;
  };

  "custom/wf-recorder" = {
    format = "{}";
    interval = "once";
    exec = "echo ''";
    tooltip = "false";
    exec-if = "pgrep 'wf-recorder'";
    on-click = "exec ./scripts/wlrecord.sh";
    signal = 8;
  };

  "custom/energy" = {
    format = "{}";
    exec = "/etc/nixos/dotfiles/scripts/watts.sh";
    interval = 1;
  };

  "custom/cooling" = {
    format = "󰏈  {}";
    exec = "/etc/nixos/dotfiles/scripts/cooling.sh";
    interval = 1;
  };

  "custom/amdpower" = {
    format = "  {}W";
    exec = "/etc/nixos/dotfiles/scipts/amdpower.sh";
    interval = 1;
  };

  "custom/bluetooth" = {
    format = "";
    exec = "blueman-manager";
    interval = 10;
  };

  "custom/hyprpicker" = {
    format = "󰈋";
    on-click = "hyprpicker -a -f hex";
    on-click-right = "hyprpicker -a -f rgb";
  };
};
}
