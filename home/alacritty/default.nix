{ pkgs, ... }:

{
  programs.alacritty = {
    enable = true;

    settings = {
      window = {
        title = "alacritty";

        padding = {
            x = 10;
            y = 10;
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
          black = "0x605a52";
          red = "0x955f5f";
          green = "0x81895d";
          yellow = "0x957f5f";
          blue = "0x7382a0";
          magenta = "0x9c739c";
          cyan  = "0x5f8c7d";
          white = "0xe4ddd2";
        };
        bright = {
          black = "0xb9a992";
          red = "0x955f5f";
          green = "0x81895d";
          yellow = "0x957f5f";
          blue = "0x7382a0";
          magenta = "0x9c739c";
          cyan = "0x5f8c7d";
          white = "0xf7f3ee";
        };
      };
    };
  };
}

