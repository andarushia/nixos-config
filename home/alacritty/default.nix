{ pkgs, ... }:

{
  programs.alacritty = {
    enable = true;

    settings = {
      window = {
        title = "alacritty";

        padding = {
            x = 30;
            y = 30;
        };
        dimensions = {
          lines = 75;
          columns = 100;
        };
      };

      font = {
        normal.family = "Iosevka Nerd Font";
        size = 14.0;
      };

    colors = {
        primary = {
          background = "0xf7f3ee";
          foreground = "0x605a52";
        };
        cursor = {
          text   = "0xe4ddd2";
          cursor = "0x605a52";
        };
        normal = {
          black = "0xf7f3ee";
          red = "0xaf0000";
          green = "0x008700";
          yellow = "0x5f8700";
          blue = "0x0087af";
          magenta = "0x878787";
          cyan  = "0x005f87";
          white = "0x444444";
        };
        bright = {
          black = "0xbcbcbc";
          red = "0xd70000";
          green = "0xd70087";
          yellow = "0x8700af";
          blue = "0xd75f00";
          magenta = "0xd75f00";
          cyan = "0x005faf";
          white = "0x005f87";
        };
      };
    };
  };
}

