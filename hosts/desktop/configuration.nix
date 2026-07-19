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
  
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  
  home-manager.users."${username}" = {
    imports = [
      ../../common/default-home.nix
      {
        home.packages = with pkgs; [
          steam
        ];
      }
    ];
  };

}
