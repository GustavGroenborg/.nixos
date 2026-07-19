# Please read the docs about stateVersion. Link is in the bottom.
{ config, lib, pkgs, ... }:

with lib;

{
  imports = [
    ./vim.nix
  ];
  
  options.custom.identity = {
    username = mkOption {
      type = types.str;
      description = "Name of the user account.";
    };
    hostname = mkOption {
      type = types.str;
      description = "The network hostname of the machine.";
    };
    stateVersion = mkOption {
      type = types.str;
      description = "The first version of NixOS installed on this machine. Read the docs: https://nixos.org/nixos/options.html";
    };
  };

  config = {
    environment.systemPackages = with pkgs; [
      curl
      wget
    ];

    virtualisation.podman = {
      enable       = true;
      dockerCompat = true;
    };

    networking.hostName = config.custom.identity.hostname;

    # Enable networking
    networking.networkmanager.enable = true;

    # Set your time zone.
    time.timeZone = "Europe/Copenhagen";

    # Select internationalisation properties.
    i18n.defaultLocale = "en_DK.UTF-8";

    i18n.extraLocaleSettings = {
      LC_ADDRESS = "da_DK.UTF-8";
      LC_IDENTIFICATION = "da_DK.UTF-8";
      LC_MEASUREMENT = "da_DK.UTF-8";
      LC_MONETARY = "da_DK.UTF-8";
      LC_NAME = "da_DK.UTF-8";
      LC_NUMERIC = "da_DK.UTF-8";
      LC_PAPER = "da_DK.UTF-8";
      LC_TELEPHONE = "da_DK.UTF-8";
      LC_TIME = "da_DK.UTF-8";
    };

    # Enable CUPS to print documents.
    services.printing.enable = true;

    # Enable sound with pipewire.
    services.pulseaudio.enable = false;
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

    # Define a user account. Don't forget to set a password with ‘passwd’.
    users.users."${config.custom.identity.username}" = {
      isNormalUser = true;
      description = "Gustav Hjort Bonnerup";
      extraGroups = [ "networkmanager" "wheel" ];
    };

    # Allow unfree packages
    nixpkgs.config.allowUnfree = true;

    # List packages installed in system profile. To search, run:
    # $ nix search wget

    nix.settings.experimental-features = [ "nix-command" "flakes" ];
    nix.settings.trusted-users = [ "root" config.custom.identity.username ];

    # Enable the OpenSSH daemon.
    services.openssh = {
      enable = true;
      settings = {
        X11Forwarding = true;
        PermitRootLogin = "no";
      };
    };

    fonts = {
      fontDir.enable = true;
      packages = with pkgs; [
        nerd-fonts.symbols-only
      ];
    };

    # Before changing this value read the documentation for this option
    # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
    system.stateVersion = config.custom.identity.stateVersion; # Did you read the comment?
  };
}
