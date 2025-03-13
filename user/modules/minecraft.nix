{ config, lib, pkgs, ... }:

{
  options.minecraftSettings = {
    enable = lib.mkEnableOption "Enable minecraft via portablemc";
  };

  config = lib.mkIf config.minecraftSettings.enable {
    home.packages = [ pkgs.portablemc ];
  };
}
