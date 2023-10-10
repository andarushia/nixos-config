{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "andalusia";
  home.homeDirectory = "/home/andalusia";

  nixpkgs = {
    config = {
        allowUnfree = true;
        allowUnfreePredicate = (_: true);
    };
  };

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    pfetch

    ripgrep
    gdb

    gcc
    go
    gnumake
    cargo
    rustc
    
    nixpkgs-fmt
    gopls
    clang-tools
    luajit
    lua-language-server
  ];

  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
    DEFAULT_USER = "$(whoami)";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # xdg.configFile = {
  #  neofetch = {
  #     source = ./files/neofetch.conf;
  #     target = "neofetch/config.conf";
  #   };
  # };

  home.pointerCursor = {
    name = "Adwaita";
    size = 24;
    package = pkgs.gnome3.adwaita-icon-theme;
  };

  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    syntaxHighlighting.enable = true;
    enableCompletion = true;
    dotDir = ".config/zsh";
    initExtra = ''
      setopt nomatch notify pipefail shwordsplit
      alias ls='ls -hF --color=tty'
      autoload -Uz colors && colors
      precmd() { print -Pn "\e]0;zsh %~%(1j, (%j job%(2j|s|)) ,)\e\\"; }
      preexec() { print -Pn "\e]0;$\{(q)1\}\e\\"; }
    '';
  };

  programs.git = {
    enable = true;
    userName = "andalusia";
    userEmail = "3dsdreamcast@gmail.com";
    extraConfig = {
      rebase = {
        autosquash = true;
      };
    };
  };
}
