
{ config, lib, pkgs, ... }:

{
  # Enable network manager
  networking.networkmanager.enable = true;

  # NetworkManager configuration for Realtek adapter priority
  networking.networkmanager.wifi.powersave = false;
  networking.networkmanager.appendNameservers = [ "1.1.1.1" "8.8.8.8" ];

  # Prioritize Realtek adapter over built-in WiFi
  networking.networkmanager.settings = {
    "device-realtek-priority" = {
      match-device = "driver:rtl*";
      "wifi.scan-rand-mac-address" = "no";
    };
    connection = {
      "connection.autoconnect-priority" = "100";
    };
  };

  # Enable mullvad vpn
  services.mullvad-vpn.enable = true;

  # Wifi adapter
  hardware.enableRedistributableFirmware = true;
  hardware.firmware = [ pkgs.linux-firmware ];

  # USB mode switching for devices that boot in storage mode
  services.udev.packages = [ pkgs.usb-modeswitch-data ];

  # Custom udev rule for Realtek adapter automatic mode switching
  services.udev.extraRules = ''
    # Realtek 802.11ac WLAN Adapter - Auto mode switch when detected
    ACTION=="add", SUBSYSTEM=="usb", ATTRS{idVendor}=="35bc", ATTRS{idProduct}=="0108", \
      RUN+="${pkgs.usb-modeswitch}/bin/usb_modeswitch -v 35bc -p 0108"

    # Set as default route when Realtek adapter appears
    ACTION=="add", SUBSYSTEM=="net", ATTRS{idVendor}=="35bc", ATTRS{idProduct}=="0108", \
      RUN+="${pkgs.iproute2}/bin/ip route add default dev %k metric 100"
  '';

  environment.systemPackages = with pkgs; [
    usb-modeswitch
    usbutils
    iw
    iproute2
  ];
}
