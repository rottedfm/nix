
{ config, pkgs, ... }:

{
  imports = [
    # Hardware configuration
    ./hardware-configuration.nix

    # Core system modules
    ../../modules/nixos/core/boot.nix
    ../../modules/nixos/core/networking.nix
    ../../modules/nixos/core/locale.nix
    ../../modules/nixos/core/audio.nix
    ../../modules/nixos/core/bluetooth.nix
    ../../modules/nixos/core/users.nix
    ../../modules/nixos/core/system.nix
    ../../modules/nixos/core/gpu.nix

    # System service modules
    ../../modules/nixos/services/printing.nix
    ../../modules/nixos/services/ollama.nix
    ../../modules/nixos/services/gaming.nix
  ];

  # Hostname (host-specific)
  networking.hostName = "fm";

  # Use latest kernel (host-specific)
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Timezone (can be made into a module if shared across hosts)
  time.timeZone = "America/New_York";

  system.stateVersion = "25.05";
}
