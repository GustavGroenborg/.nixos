{ config, pkgs, ... }:
{
  home.username      = "gcrg";
  home.homeDirectory = "/home/gcrg";

  programs.git = {
    enable    = true;
    userName  = "Gustav C. R. Grønborg";
    userEmail = "gustavrisagerus@gmail.com";
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
    nil
    clang-tools
  ];

  home.stateVersion = "25.11";
}
