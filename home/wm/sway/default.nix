{ config, pkgs, lib, ... }: {
  wayland.windowManager.sway = {
    enable = true;
    systemd.enable = true;

    extraSessionCommands = ''
      export MOZ_ENABLE_WAYLAND=1
      export QT_QPA_PLATFORM=wayland
      export SDL_VIDEODRIVER=wayland
      export GTK_THEME=Adwaita:light

      # home-manager home.sessionVariables
      source ~/.nix-profile/etc/profile.d/hm-session-vars.sh
    '';

    swaynag = {
      enable = true;
      settings = {
        "<config>" = {
          edge = "bottom";
          font = "Iosevka Nerd Font 14";
          border-bottom-size = "0";
        };
        warning = {
          background = "f7f3ee";
          text = "614c61";
          border = "f1ddf1";
          button-background = "f1ddf1";
        };
      };
    };

    wrapperFeatures.gtk = true;

    config = {
      modifier = "Mod4";
      bindkeysToCode = true;
      terminal = "${pkgs.alacritty}/bin/alacritty";
      menu = "${pkgs.fuzzel}/bin/fuzzel";
      workspaceAutoBackAndForth = true;

      bars = [
        {
          command = "${pkgs.waybar}/bin/waybar";
        }
      ];

      colors =
        let
		  base1	        = "#605a52";
		  base2	        = "#93836c";
		  base3	        = "#b9a992";
		  base4         = "#dcd3c6";
		  base5	        = "#e4ddd2";
		  base6         = "#f1ece4";
		  base7	        = "#f7f3ee";
		  accent	    = "#6a4cff";
		  orangeText    = "#5b5143";
		  orangeTextSec = "#957f5f";
		  orangeBg      = "#f7e0c3";
		  greenText     = "#525643";
		  greenTextSec  = "#81895d";
		  greenBg       = "#e2e9c1";
		  tealText      = "#465953";
		  tealTextSec   = "#5f8c7d";
		  tealBg        = "#d2ebe3";
		  blueText      = "#4c5361";
		  blueTextSec   = "#7382a0";
		  blueBg        = "#dde4f2";
		  purpleText    = "#614c61";
		  purpleTextSec = "#9c739c";
		  purpleBg      = "#f1ddf1";
		  white	        = "#ffffff";
          focused = base5;
          inactive = base7;
          unfocused = base7;
          urgent = orangeBg;
        in
        {
          focused = {
            border = focused;
            background = focused;
            text = base1;
            indicator = orangeBg;
            childBorder = "";
          };
          focusedInactive = {
            border = inactive;
            background = inactive;
            text = base1;
            indicator = orangeBg;
            childBorder = "";
          };
          unfocused = {
            border = unfocused;
            background = unfocused;
            text = base1;
            indicator = orangeBg;
            childBorder = "";
          };
          urgent = {
            border = urgent;
            background = orangeBg;
            text = orangeText;
            indicator = orangeBg;
            childBorder = "";
          };
        };

      floating = {
        border = 2;
        titlebar = true;
        criteria = [
          {
            app_id = "^alacritty$";
          }
        ];
      };

      focus = {
        newWindow = "urgent";
      };

      fonts = {
        names = [ "Iosevka Nerd Font" ];
        size = 10.0;
      };

      gaps = {
        smartGaps = true;
        smartBorders = "on";
        inner = 10;
        outer = 0;
      };

      output = {
        "*" = {
          bg = "`find ~/.config/home-manager/home/files/penguin.jpg -type f | shuf -n1` fill #282828";
        };
      };

      input = {
        "type:pointer" = {
          accel_profile = "flat";
        };
        "type:keyboard" = {
          xkb_layout = "us,ru";
          xkb_options = "grp:shifts_toggle,ctrl:nocaps";
        };
        "type:touchpad" = {
          accel_profile = "flat";
          tap = "yes";
          dwt = "yes";
          tap_button_map = "lrm";
          natural_scroll = "yes";
        };
      };

      keybindings =
        let
          mod = config.wayland.windowManager.sway.config.modifier;
          up = config.wayland.windowManager.sway.config.up;
          down = config.wayland.windowManager.sway.config.down;
          left = config.wayland.windowManager.sway.config.left;
          right = config.wayland.windowManager.sway.config.right;
          floating_term = "${config.wayland.windowManager.sway.config.terminal} -a alacritty";
        in
        lib.mkOptionDefault {
          # Media keys
          XF86MonBrightnessDown = "exec ${pkgs.light}/bin/light -T 0.72";
          XF86MonBrightnessUp = "exec ${pkgs.light}/bin/light -T 1.4";
          
          #XF86AudioRaiseVolume = "exec ${pkgs.pulseaudio}/bin/pactl set-sink-volume @DEFAULT_SINK@ +1%";
          XF86AudioRaiseVolume = "exec ${pkgs.alsa-utils}/bin/amixer set Master 5%+";
          #XF86AudioLowerVolume = "exec ${pkgs.pulseaudio}/bin/pactl set-sink-volume @DEFAULT_SINK@ -1%";
          XF86AudioLowerVolume = "exec ${pkgs.alsa-utils}/bin/amixer set Master 5%-";
          # XF86AudioMute = "exec ${pkgs.pulseaudio}/bin/pactl set-sink-mute @DEFAULT_SINK@ toggle";
          XF86AudioMute = "exec ${pkgs.alsa-utils}/bin/amixer set Master toggle";
          XF86AudioMicMute = "exec ${pkgs.pulseaudio}/bin/pactl set-source-mute @DEFAULT_SOURCE@ toggle";

          XF86NotificationCenter = "exec ${pkgs.mako}/bin/makoctl dismiss -a";

          XF86Favorites = "exec ${config.wayland.windowManager.sway.config.menu}";

          XF86Display = "output eDP-1 toggle";

          # General actions
          "${mod}+Shift+Return" = "exec ${floating_term}";

          "${mod}+p" = "exec ${pkgs.sway-contrib.grimshot}/bin/grimshot copy output";
          Print = "exec ${pkgs.sway-contrib.grimshot}/bin/grimshot copy output";
          "${mod}+Shift+p" = "exec ${pkgs.sway-contrib.grimshot}/bin/grimshot copy area";
          "Ctrl+Print" = "exec ${pkgs.sway-contrib.grimshot}/bin/grimshot copy area";
          "${mod}+Ctrl+p" = "exec ${pkgs.sway-contrib.grimshot}/bin/grimshot copy window";

          # Workspaces
          "${mod}+Ctrl+${up}" = "workspace prev_on_output";
          "${mod}+Ctrl+${down}" = "workspace next_on_output";
          "${mod}+Ctrl+Up" = "workspace prev_on_output";
          "${mod}+Ctrl+Down" = "workspace next_on_output";

          "${mod}+Ctrl+Shift+${up}" = "move container to workspace prev_on_output";
          "${mod}+Ctrl+Shift+${down}" = "move container to workspace next_on_output";
          "${mod}+Ctrl+Shift+Up" = "move container to workspace prev_on_output";
          "${mod}+Ctrl+Shift+Down" = "move container to workspace next_on_output";

          # Outputs
          "${mod}+Ctrl+${left}" = "focus output left";
          "${mod}+Ctrl+${right}" = "focus output right";
          "${mod}+Ctrl+Left" = "focus output left";
          "${mod}+Ctrl+Right" = "focus output right";

          "${mod}+Ctrl+Shift+${left}" = "move workspace to output left";
          "${mod}+Ctrl+Shift+${right}" = "move workspace to output right";
          "${mod}+Ctrl+Shift+Left" = "move workspace to output left";
          "${mod}+Ctrl+Shift+Right" = "move workspace to output right";

          # Global fullscreen
          "${mod}+Shift+f" = "fullscreen toggle global";

          # Modes
          "${mod}+Equal" = "mode passthrough";
          "${mod}+c" = "mode config";
        };

      modes = lib.mkOptionDefault {
        passthrough = {
          "${config.wayland.windowManager.sway.config.modifier}+Equal" =
            "mode default";
        };
        config = {
          p = "exec swaynag -t warning -m 'Poweroff?' -b 'Yes' 'systemctl poweroff'; mode default";
          r = "exec swaynag -t warning -m 'Reboot?' -b 'Yes' 'systemctl reboot'; mode default";
          s = "exec systemctl suspend; mode default";
          "--release l" = "exec loginctl lock-session; mode default";

          b = "exec ${pkgs.light}/bin/light -T 1.4";
          "Shift+b" = "exec ${pkgs.light}/bin/light -T 0.72";

          v = "exec ${pkgs.alsa-utils}/bin/amixer set Master 5%+";
          "Shift+v" = "exec ${pkgs.alsa-utils}/bin/amixer set Master 5%-";
          m = "exec ${pkgs.alsa-utils}/bin/amixer set Master toggle";
          "Shift+m" = "exec ${pkgs.pulseaudio}/bin/pactl set-source-mute @DEFAULT_SOURCE@ toggle";

          n = "exec ${pkgs.mako}/bin/makoctl dismiss -a";
          
          w = "exec ${pkgs.wlsunset}/bin/wlsunset";

          Return = "mode default";
          Escape = "mode default";
        };
      };

      seat = {
        "*" = {
          hide_cursor = "4000";
          idle_wake = "keyboard";
          xcursor_theme = "Adwaita 24";
        };
      };

      window = {
        border = 2;
        titlebar = false;
      };
    };
  };
}
