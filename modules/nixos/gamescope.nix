{ pkgs, ... }:

{
  environment.systemPackages = [ pkgs.gamescope ];

  services.dbus.enable = true;

  xdg.portal = {
    enable = true;
    config.common.default = "*";  # <- this suppresses the warning
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];  # or plasma/gnome
  };
}
