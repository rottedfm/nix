{ pkgs, ... }:

{
  services.xserver = {
    enable = true;
    videoDrivers = [ "amdgpu" ];
  };

  environment.systemPackages = [ pkgs.bibata-cursors ];
}
