{ config, pkgs, ... }:

{
  # Web browsers
  # Moved from nixos/core/system.nix

  home.packages = with pkgs; [
    chromium  # Open-source web browser
    # florp is configured in florp.nix
  ];
}
