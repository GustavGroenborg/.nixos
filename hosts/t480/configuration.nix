# WIP
let
  username     = "gcrg";
  hostname     = "t480";
  stateVersion = "25.11";
in
{ config, pkgs, ... }: {
  
  imports = [
    ./hardware-configuration.nix
    ../../common/default-configuration.nix
    ../../common/desktop-environments/cosmic.nix
  ];

  # Passing variables to modules imported above
  custom.identity = {
    inherit username hostname stateVersion;
  };
  
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelParams = [ "mem_sleep_default=deep" ];

  # Enable touchpad support (enabled default in most desktopManager).
  # TODO: automated configuration file, write `services.xserver.libinput.enable, but this option has been renamed. Consider making an issue for this.
  # services.libinput.enable = false;
  # services.libinput.touchpad.sendEventsMode = "disabled";

  home-manager.users."${username}" = {
    imports = [
      ../../common/default-home.nix
      # {
      #   home.packages = with pkgs; [
      #     ... Add new packages here
      #   ];
      # }
    ];
  };
}
