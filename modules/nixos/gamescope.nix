{ pkgs, ... }:

{
  environment.systemPackages = [ pkgs.gamescope ];

  services.dbus.enable = true;

  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
}
