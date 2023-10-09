{ pkgs, ... }: {
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";

        modules-left = [
          "sway/mode"
          "sway/workspaces"
          "sway/window"
        ];

        modules-right = [
          "pulseaudio"
          # "network"
          "battery"
          "sway/language"
          "tray"
          "clock#date"
          "clock#time"
        ];

        battery = {
          interval = 10;
          states = {
            warning = 30;
            critical = 15;
          };
          format = "{icon}  {capacity}%";
          format-charging = " {capacity}%";
          format-charging-full = " {capacity}%";
          format-full = "{icon}  {capacity}%";
          format-alt = "{icon}  {power}W";
          format-icons = [
            ""
            ""
            ""
            ""
            ""
          ];
          tooltip = false;
        };

        "clock#time" = {
          interval = 10;
          format = "{:%H:%M}";
          tooltip = false;
        };

        "clock#date" = {
          interval = 20;
          format = "{:%e %b %Y}";
          tooltip = false;
        };

        "sway/language" = {
          format = "  {}";
          min-length = 5;
          on-click = "${pkgs.sway}/bin/swaymsg 'input * xkb_switch_layout next'";
          tooltip = false;
        };

        network = {
          interval = 5;
          format-wifi = "  {essid}";
          format-ethernet = "{ifname}";
          format-disconnected = "NaN";
          format-alt = "{ipaddr}/{cidr}";
          tooltip = false;
        };

        "sway/mode" = {
          format = "{}";
          tooltip = false;
        };

        "sway/window" = {
          format = "{}";
          max-length = 30;
          tooltip = false;
        };

        "sway/workspaces" = {
          disable-scroll-wraparound = true;
          smooth-scrolling-threshold = 4;
          enable-bar-scroll = true;
          format = "{name}";
        };

        pulseaudio = {
          format = "{icon} {volume}%";
          format-muted = "";
          format-icons = {
            default = [ "" ];
            # 
          };
          scroll-step = 1;
          on-click = "${pkgs.pulseaudio}/bin/pactl set-sink-mute @DEFAULT_SINK@ toggle";
          tooltip = false;
        };

        tray = {
          icon-size = 22;
        };
      };
    };

    style = ./waybar.css;
  };
}
