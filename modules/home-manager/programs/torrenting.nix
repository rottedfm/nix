{ config, pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    qbittorrent  # Feature-rich BitTorrent client
    ppsspp-sdl   # PSP emulator (SDL version)
  ];

  # qBittorrent configuration
  # Note: qBittorrent doesn't have a home-manager module,
  # so we install it as a package. Configuration is done through the GUI.
}
