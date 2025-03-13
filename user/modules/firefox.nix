{ config, pkgs, lib, ... }:

{
  options.firefoxSettings = {
    enable = lib.mkEnableOption "Enable firefox for the user.";
  };

  config = lib.mkIf config.firefoxSettings.enable {
    programs.firefox = {
      enable = true;
      package = pkgs.unstable.firefox;
    };
  };
}
