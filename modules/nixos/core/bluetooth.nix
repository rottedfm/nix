{ config, lib, pkgs, ... }:

{
  # Enable Bluetooth
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings = {
      General = {
        Enable = "Source,Sink,Media,Socket";
        Experimental = true;
      };
    };
  };

  # Enable Bluetooth service
  services.blueman.enable = true;

  # Add bluetuith TUI application
  environment.systemPackages = with pkgs; [
    bluetuith
  ];
}
