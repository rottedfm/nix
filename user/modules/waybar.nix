{ config, lib, pkgs, ... }:

{
  options.waybarSettings = {
    enable = lib.mkEnableOption "Enable Waybar for the user.";
    settings = lib.mkOption {
      type = lib.types.attrs; 
      default = {};
      description = "Waybar config settings.";
    };
  };

  config = lib.mkIf config.waybarSettings.enable {
    programs.waybar = {
      enable = true;
      package = pkgs.unstable.waybar;
      settings = config.waybarSettings.settings;
    };
  };
}
