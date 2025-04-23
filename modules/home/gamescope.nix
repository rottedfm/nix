{ pkgs, ... }:

{
  home.packages = with pkgs; [ gamescope ];

  services.dbus.enable = true;

  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ]; # or plasma/gnome depending on your setup
}
}
