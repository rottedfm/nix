{ config, pkgs, ... }:


{
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  boot.initrd.kernelModules = [ "amdgpu" ];

  hardware.enableRedistributableFirmware = true;

  environment.systemPackages = with pkgs; [
    glxinfo
    glfw-wayland
  ];
  
}
