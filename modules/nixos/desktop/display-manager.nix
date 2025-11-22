{ config, lib, pkgs, ... }:

{
  # Use greetd with tuigreet as the display manager
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        # tuigreet with session selection support
        # The --sessions flag tells tuigreet where to find desktop session files
        # The --remember flag remembers the last selected session
        # Users can select between available sessions (niri, GNOME, etc.)
        command = "${pkgs.tuigreet}/bin/tuigreet --time --remember --sessions /run/current-system/sw/share/wayland-sessions:/run/current-system/sw/share/xsessions";
        user = "greeter";
      };
    };
  };

  # Enable X server for GNOME compatibility
  services.xserver.enable = true;

  # XDG portal for screen sharing and desktop integration (needed for both Wayland compositors)
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
      xdg-desktop-portal-gnome
    ];
    config = {
      common.default = "*";
      gnome.default = [ "gnome" "gtk" ];
      niri.default = [ "gnome" "gtk" ];
    };
  };
}
