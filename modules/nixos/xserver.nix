{ pkgs, ... }:

{

  services.displayManager.ly.enable = true;
  
  services.xserver = {
    enable = true;
    videoDrivers = [ "amdgpu" ];
  };

  environment.systemPackages = [ pkgs.bibata-cursors ];
}
