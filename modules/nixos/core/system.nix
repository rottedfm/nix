{ config, lib, pkgs, ... }:

{
  # Core system configuration
  # User applications have been moved to home-manager modules

  # System-wide programs
  programs.direnv.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Nix settings
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
}
