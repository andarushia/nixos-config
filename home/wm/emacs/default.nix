{ flake-inputs, pkgs, config, lib, ... }:

{
  imports = [
    flake-inputs.nix-doom-emacs.hmModule
  ];

  services.emacs.enable = true;

  programs.doom-emacs = {
    enable = true;
    doomPrivateDir = ./doom.d;
  };

  home.packages = with pkgs; [
    # DOOM Emacs dependencies
    binutils
    (ripgrep.override { withPCRE2 = true; })
    gnutls
    fd
    imagemagick
    zstd
    nodePackages.javascript-typescript-langserver
    sqlite
    editorconfig-core-c
    emacs-all-the-icons-fonts
  ];
}
