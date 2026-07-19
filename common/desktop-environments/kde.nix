{ config, pkgs, ... }: {
  # NixOS docs: https://wiki.nixos.org/wiki/KDE
  services.desktopManager.plasma6.enable = true;

  # Default display manager for Plasma
  services.displayManager.plasma-login-manager.enable = true;

  # Optionally enable xserver
  services.xserver.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };


}
