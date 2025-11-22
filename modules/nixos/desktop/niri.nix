{ config, lib, pkgs, ... }:

{
  # Enable Niri compositor (system-level)
  # User tools and utilities have been moved to home-manager desktop/wayland-tools.nix
  programs.niri.enable = true;

  # System-level packages requiring root or system integration
  environment.systemPackages = with pkgs; [
    brightnessctl  # Brightness control (needs system permissions)
  ];
}
