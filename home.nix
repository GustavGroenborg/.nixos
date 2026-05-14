{ config, pkgs, ... }:
{
  home.username      = "gcrg";
  home.homeDirectory = "/home/gcrg";

  gtk = {
    enable = true;
    iconTheme = {
      package = pkgs.adwaita-icon-theme;
      name = "Adwaita";
    };
  };

  services.emacs.enable = true;
  services.ssh-agent.enable = true;

  systemd.user.services.emacs = {
    Unit.After = [ "graphical-session.target" ];
    Install.WantedBy = pkgs.lib.mkForce [ "graphical-session.target" ];
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  programs.git = {
    enable    = true;
    settings.user = {
      name  = "Gustav C. R. Grønborg";
      email = "gustavrisagerus@gmail.com";
    };

    ignores = [
      "*~"
      "*.swp"
      ".direnv/"
      ".envrc.local"
    ];

  };

  #  programs.zsh = {
  #    enable = true;
  #    enableCompletion = true;
  #  };

  programs.emacs = {
    enable  = true;
    package = pkgs.emacs;
  };

  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    matchBlocks."*" = {
      addKeysToAgent = "yes";
      forwardAgent = false;
      compression = false;
      controlMaster = "no";
      controlPath = "~/.ssh/master-%r@%n:%p";
      controlPersist = "no";
      hashKnownHosts = false;
      serverAliveCountMax = 3;
      serverAliveInterval = 0;
      userKnownHostsFile = "~/.ssh/known_hosts";
    };
  };

  home.packages = with pkgs; [
    #clang-tools # Uncomment his is anything unexpectedly breaks
    devenv # TODO: delete after semester end
    libreoffice
    nixd
    texliveFull
  ];

  home.stateVersion = "25.11";
}
