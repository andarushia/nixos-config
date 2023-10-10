{ pkgs, ... }: {
  imports = [
    ./sway
    ./waybar
    ./emacs
  ];

  home.packages = with pkgs; [
    firefox
    discord
    tdesktop
    irssi
    wlsunset

    # fonts
    (nerdfonts.override { fonts = [ "Iosevka" ]; }) 
  ];

  programs.fuzzel = {
    enable = true;
    settings = {
      main = {
        font = "Iosevka Nerd Font:size=14";
        dpi-aware = false;
        prompt = "'~ '";
        terminal = "alacritty";
        launch-prefix = "swaymsg exec --";
        icons-enabled = false;

        lines = 20;
        width = 60;
        horizontal-pad = 8;
        vertical-pad = 4;
        inner-pad = 4;

        exit-on-keyboard-focus-loss = false;
      };
      colors = {
        background = "f7f3eeff";
        text = "605a52ff";
        match = "605a52ff";
        selection-match = "9c739cff";
        selection = "f1ddf1ff";
        selection-text = "614c61ff";
        border = "e4ddd2ff";
      };
      border = {
        width = 3;
        radius = 0;
      };
      key-bindings = {
        next = "Mod1+j Down Control+n";
        prev = "Mod1+k Up Control+p";
      };
    };
  };

  programs.imv = {
    enable = true;
    settings = {
      options = {
        background = "f7f3ee";
        overlay_text_color = "4c5361";
        overlay_background_color = "dde4f2";
        overlay_font = "Iosevka Nerd Font:14";
      };
    };
  };

  programs.mpv = {
    enable = true;
    config = {
      osd-font = "Iosevka Nerd Font";
      osd-font-size = 20;
      osd-color = "#f7f3ee";
      osd-border-color = "#e4ddd2";
    };
  };

  services.mako = {
    enable = true;
    font = "Iosevka Nerd Font 10";
    backgroundColor = "#f7f3ee";
    anchor = "bottom-right";
    maxIconSize = 44;
    borderColor = "#e4ddd2";
    textColor = "#605a52";
    progressColor = "source #9c739c";
    borderRadius = 0;
    borderSize = 2;
    defaultTimeout = 5000;
    margin = "5";
    height = 70;
    width = 250;
  };

  services.wlsunset = {
    enable = true;
    latitude = "56";
    longitude = "38";
    temperature.night = 4500;
  };

  fonts.fontconfig.enable = true;
}
