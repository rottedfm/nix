{ config, pkgs, ... }:

{
  # Wayland utilities and tools

  home.packages = with pkgs; [
    # Launchers and UI
    fuzzel         # Application launcher for Wayland

    # Screenshots
    grim           # Screenshot utility for Wayland
    slurp          # Region selector for Wayland

    # Clipboard
    wl-clipboard   # Wayland clipboard utilities

    # Media and audio
    pamixer        # PulseAudio mixer
    playerctl      # Media player controller

    # XWayland support
    xwayland-satellite
  ];

  # Environment variables for XWayland support
  home.sessionVariables = {
    DISPLAY = ":0";
  };
}
