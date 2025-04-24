{ pkgs, ... }:

{

  
  services.xserver = {
    enable = true;
    videoDrivers = [ "amdgpu" ];
    displayManager.startx.enable = true;
  };

  environment.systemPackages = [ pkgs.xwayland pkgs.xwayland-satellite pkgs.bibata-cursors ];
}
