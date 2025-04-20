{ pkgs, ... }:

{
  services.xserver = {
    enable = true;
    videoDrivers = [ "amdgpu" ];
    displayManager.ly.enable = true;
  };

  environment.systemPackages = [ pkgs.bibata-cursors ];
}
