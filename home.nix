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

  programs.emacs = {
    enable  = true;
    package = pkgs.emacs;
  };

  programs.ssh = {
    enable = true;
    settings = {
      "Host *" = {
        "AddKeysToAgent"       = "yes";
        "ForwardAgent"         = "no";
        "Compression"          = "no";
        "ControlMaster"        = "no";
        "ControlPath"          = "~/.ssh/master-%r@%n:%p";
        "ControlPersist"       = "no";
        "HashKnownHosts"       = "no";
        "ServerAliveCountMax"  = "3";
        "ServerAliveInterval"  = "0";
        "UserKnownHostsFile"   = "~/.ssh/known_hosts";
      };
    };
  };

  home.packages = with pkgs; [
    bc
    devenv # TODO: delete after semester end
    libreoffice
    nixd
    texliveFull
  ];

  home.stateVersion = "25.11";
}
