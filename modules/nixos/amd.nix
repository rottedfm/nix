{ config, pkgs, ... }:


{
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [ vulkan-loader vulkan-tools vulkan-validation-layers ];
  };

  boot.initrd.kernelModules = [ "amdgpu" ];

  hardware.enableRedistributableFirmware = true;

  environment.systemPackages = with pkgs; [
    mesa-demos
    mangohud
  ];
}
