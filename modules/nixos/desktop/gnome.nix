{ config, pkgs, ... }:

{
  # Enable GNOME desktop manager (system-level service)
  # Display manager (tuigreet) configured in display-manager.nix
  # User applications and settings in home-manager desktop/gnome.nix
  services.desktopManager.gnome.enable = true;

  # Explicitly disable GDM - we use tuigreet instead
  services.displayManager.gdm.enable = false;

  # Disable unnecessary GNOME components
  services.gnome.core-apps.enable = false;
  services.gnome.core-developer-tools.enable = false;
  services.gnome.games.enable = false;
  environment.gnome.excludePackages = with pkgs; [ gnome-tour gnome-user-docs ];
}
