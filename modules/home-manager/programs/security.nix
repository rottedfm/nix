{ config, pkgs, ... }:

{
  # Security and privacy applications

  home.packages = with pkgs; [
    bitwarden-desktop  # Password manager
    protonmail-bridge  # Proton Mail desktop bridge
  ];
}
