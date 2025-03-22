{ config, lib, ... }:

{
  options.gitSettings = {
    enable = lib.mkEnableOption "Enable git for the system.";
  };

  config = lib.mkIf config.gitSettings.enable {
    programs.git = {
      enable = true;
    };
  };
}
