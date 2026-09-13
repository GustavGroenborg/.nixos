let
  username     = "ghb";
  hostname     = "desktop";
  stateVersion = "26.05";
in
{ config, pkgs, ... }: {
    
  imports = [
    ./hardware-configuration.nix
    ../../common/default-configuration.nix
    ../../common/desktop-environments/kde.nix
  ];

  # Passing variables to modules imported above
  custom.identity = {
    inherit username hostname stateVersion;
  };

  boot.kernelModules = [
    "nct6683" # Driver for motherboard fans
  ];

  boot.kernelPackages = pkgs.linuxPackages_xanmod_latest;

  boot.kernelParams = [
    "split_lock_mitigate=0"
  ];

  boot.kernel.sysctl = {
    "vm.max_map_count" = 2147483642;
  };
  
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  hardware.graphics.enable = true;
  hardware.graphics.enable32Bit = true;

  programs.coolercontrol.enable = true;
  programs.gamemode.enable = true;

  services.scx = {
    enable    = true;
    scheduler = "scx_lavd";
  };
  
  home-manager.users."${username}" = {
    imports = [
      ../../common/default-home.nix
      {
        home.packages = with pkgs; [
          steam
          kdePackages.kdeconnect-kde
        ];
      }
    ];
  };

}
