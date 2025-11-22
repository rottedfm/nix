{ config, pkgs, ... }:

{
  # Wayland utilities and tools
  # Moved from nixos/desktop/niri.nix

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
    xwayland-satellite  # Xwayland outside your Wayland compositor
  ];

  # Environment variables for XWayland support in niri
  home.sessionVariables = {
    DISPLAY = ":0";
  };
}
