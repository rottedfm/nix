{ config, lib, pkgs, ... }:

{ 
  options.hyprlandSettings = {
    enable = lib.mkEnableOption "Enable Hyprland for the system";
  };

  config = lib.mkIf config.hyprlandSettings.enable {
    programs.hyprland = {
      enable = true;
      portalPackage = pkgs.xdg-desktop-portal-hyprland;
      xwayland.enable = true;
    };

    services.xserver = {
      enable = true;
      xkb.layout = "us";
      xkb.variant = "";
      displayManager.lightdm.enable = false;
    };
  };
}

