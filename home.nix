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

  services.ssh-agent.enable = true;

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
    clang-tools
    devenv # TODO: delete after semester end
    libreoffice
    nixd
    texliveFull
  ];

  home.stateVersion = "25.11";
}
