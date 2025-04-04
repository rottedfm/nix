{ config, ... }:

{
  services.xserver = {
    enable = true;
    videoDrivers = [ "amdgpu" ];
    displayManager.startx.enable = true;
    desktopManager = {
      cinnamon.enable = true;
    };
  };
}
