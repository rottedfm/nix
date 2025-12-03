{ config, lib, pkgs, ... }:

{
  # Core system configuration
  # User applications have been moved to home-manager modules

  # System-wide programs
  programs.direnv.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Nix settings with optimizations
  nix.settings = {
    # Enable experimental features
    experimental-features = [ "nix-command" "flakes" ];

    # Build optimizations
    max-jobs = "auto";  # Use all available CPU cores
    cores = 0;  # Use all available cores per job

    # Enable parallel building
    auto-optimise-store = true;  # Automatically optimize the store

    # Binary cache optimizations
    substituters = [
      "https://cache.nixos.org"
      "https://nix-community.cachix.org"
    ];
    trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];

    # Keep build outputs for faster rebuilds
    keep-outputs = true;
    keep-derivations = true;
  };

  # Automatic garbage collection
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };

  # Use zstd compression for better performance
  nix.settings.compression-level = "fast";
}
