{ flake, pkgs, ... }:

let
  inherit (flake.inputs) niri-flake;
in 
{
  imports =
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  hardware.firmware = with pkgs; [
    linux-firmware
  ];
  hardware.enableAllFirmware = true;

  networking.hostName = "fm"; # Define your hostname.
  networking.nameservers = [ "8.8.8.8" "1.1.1.1" ];

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/New_York";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Define a user account
  users.users.rotted = {
    isNormalUser = true;
    description = "rotted";
    extraGroups = [ "networkmanager" "wheel" "input" "video" ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  nixpkgs.overlays = [
    niri-flake.overlays.niri
  ];

  # Enable flakes and the 'nix' command
  nix.settings.experimental-features = [ "flakes" "nix-command" ];

  system.stateVersion = "24.11"; # Nix system version

}
