{ config, lib, osConfig, pkgs, ...}:

with lib;

{
  # gtk = {
  #   enable = true;
  #   iconTheme = {
  #     package = pkgs.adwaita-icon-theme;
  #     name = "Adwaita";
  #   };
  # };
  
  home.username      = osConfig.custom.identity.username;
  home.homeDirectory = "/home/${osConfig.custom.identity.username}";
  home.stateVersion  = osConfig.custom.identity.stateVersion;
  home.packages = with pkgs; [
    bc
    devenv # Consider deleting at some point
    htop
    just
    kdePackages.okular
    libreoffice
    nixd
    ripgrep
    texliveFull
    tree
  ];

  programs.direnv = {
    enable            = true;
    nix-direnv.enable = true;
  };

  programs.emacs = {
    enable  = true;
    package = pkgs.emacs;
  };

  programs.firefox.enable = true;

  programs.git = {
    enable = true;
    settings.user = {
      name  = "Gustav Hjort Bonnerup";
      email = "gustav@hjortbonnerup.dk";
    };

    ignores = [
      "*~"
      "*.swp"
      ".direnv/"
      ".envrc.local"
    ];
  };

  programs.ssh = {
    enable   = true;
    settings = {
      "Host *" = {
        "AddKeysToAgent"      = "yes";
        "ForwardAgent"        = "no";
        "Compression"         = "no";
        "ControlMaster"       = "no";
        "ControlPath"         = "~/.ssh/master-%r@%n:%p";
        "ControlPersist"      = "no";
        "HashKnownHosts"      = "no";
        "ServerAliveCountMax" = "3";
        "ServerAliveInterval" = "0";
        "UserKnownHostsFile"  = "~/.ssh/known_hosts";
      };
    };
  };

  services.emacs.enable     = true;
  services.ssh-agent.enable = true;
  
  systemd.user.services.emacs = {
    Unit.After = [ "graphical-session.target" ];
    Install.WantedBy = pkgs.lib.mkForce [ "graphical-session.target" ];
  };

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
    "application/pdf" = "okular.desktop";
    };
  };
}
