
{ config, lib, pkgs, ... }:

{
  # Enable network manager
  networking.networkmanager.enable = true;

  # NetworkManager configuration for Realtek adapter priority
  networking.networkmanager.wifi.powersave = false;
  networking.networkmanager.appendNameservers = [ "1.1.1.1" "8.8.8.8" ];

  # Enable mullvad vpn
  services.mullvad-vpn.enable = true;

  # Wifi adapter
  hardware.enableRedistributableFirmware = true;
  hardware.firmware = [ pkgs.linux-firmware ];

  # USB mode switching for devices that boot in storage mode
  services.udev.packages = [ pkgs.usb-modeswitch-data ];

  environment.systemPackages = with pkgs; [
    usb-modeswitch
    usbutils
    iw
    iproute2
  ];
}
