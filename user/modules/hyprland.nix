{ config, pkgs, lib, ... }:

{
  options.hyprlandSettings = {
    enable = lib.mkEnableOption "Enable Hyprland for the user.";
    settings = lib.mkOption {
      type = lib.types.attrs;
      default = {};
      description = "Hyprland configuration settings";
    };
  };

  config = lib.mkIf config.hyprlandSettings.enable {
    wayland.windowManager.hyprland = {
      enable = true;
      xwayland.enable = true;
      settings = config.hyprlandSettings.settings;
    };
  };
}
