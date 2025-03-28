{ config, pkgs, lib, ... }:

{
  options.firefoxSettings = {
    enable = lib.mkEnableOption "Enable firefox for the user.";
  };

  config = lib.mkIf config.firefoxSettings.enable {
    programs.librewolf = {
      enable = true;
      package = pkgs.unstable.librewolf;
    };
  };
}
