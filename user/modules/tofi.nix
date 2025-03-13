{ config, lib, ... }:

{
  options.tofiSettings = {
    enable = lib.mkEnableOption "Enable tofi for the user";
    settings = lib.mkOption {
      type = lib.types.attrs;
      default = {};
      description = "tofi configuration settings.";
    };
  };

  config = lib.mkIf config.tofiSettings.enable {
    programs.tofi = {
      enable = true;
      settings = config.tofiSettings.settings;
    };
  };
}
