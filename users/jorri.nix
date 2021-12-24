{ config, pkgs, lib, ... }:
let
  isNixOS = builtins.pathExists /etc/NIXOS;
in
{

  home.stateVersion = "21.11";

  home.language.base = "en_US.UTF-8";

  home.username = "jorri";
  home.homeDirectory = "/home/jorri";
  home.sessionVariables = {
    EDITOR = "nvim";
  };


  imports = [
    ../modules/neovim
  ];

  nixpkgs.config.allowUnfree = true;
  programs.home-manager.enable = true;
  home.packages = with pkgs; [

    btop
    tmux
    zsh
    tree

    subversionClient
    git gh
    fossil tk tcl

    gdb

    exa
    fzf
    ripgrep
    colordiff

    xclip

    pass

  ]
  ++ lib.optionals isNixOS
  [
    nextcloud-client
    passff-host
    (firefox.override { extraNativeMessagingHosts = [ passff-host ]; } )
    alacritty
  ];

  programs.git = {
    enable = true;
    userName = "Jorri Fransen";
    userEmail = "jorri@jorrifransen.nl";
    signing = {
      signByDefault = true;
      key = "0980CB294516B081";
    };
  };
}
