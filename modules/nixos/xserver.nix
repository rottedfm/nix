{ pkgs, ... }:

{
  services.xserver = {
    enable = true;
    videoDrivers = [ "amdgpu" ];
    displayManager.startx.enable = true;
    desktopManager = {
      cinnamon.enable = true;
    };
  };

  environment.systemPackages = [ pkgs.bibata-cursors ];
}
