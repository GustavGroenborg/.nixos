{ config, pkgs, ... }: {
  # Enable COSMIC login manager and desktop environment
  services = {
    displayManager.cosmic-greeter.enable = true;
    desktopManager.cosmic.enable = true;
    system76-scheduler.enable = true;
  };

  environment.cosmic.excludePackages = with pkgs; [
    cosmic-edit
  ];
}
