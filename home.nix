{ config, pkgs, ... }:
{
  home.username      = "gcrg";
  home.homeDirectory = "/home/gcrg";

  programs.git = {
    enable    = true;
    settings.user = {
      name  = "Gustav C. R. Grønborg";
      email = "gustavrisagerus@gmail.com";
    };

  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
  };

  programs.emacs = {
    enable  = true;
    package = pkgs.emacs-gtk;
  };

  home.packages = with pkgs; [
    nixd
    clang-tools
  ];

  home.stateVersion = "25.11";
}
