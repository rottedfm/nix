{ config, lib, pkgs, ... }:

{
  options.helixSettings = {
    enable = lib.mkEnableOption "Enable helix editor for the system.";
    settings = lib.mkOption {
      type = lib.types.attrs;
      default = {};
      description = "Helix configuration settings.";
    };
    languages = lib.mkOption {
      type = lib.types.attrs;
      default = {};
      description = "Helix language configuration settings";
    };
    packages = lib.mkOption {
      type = lib.types.listOf lib.types.package;
      default = [];
      description = "Additional packages / lsps";
    };
  };

  config = lib.mkIf config.helixSettings.enable {
    programs.helix = {
      enable = true;
      settings = config.helixSettings.settings;
      languages = config.helixSettings.languages;
    };

    home.packages = config.helixSettings.packages;
  };
}
