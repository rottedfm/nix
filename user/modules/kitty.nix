{ config, pkgs, lib, ... }:

{
  options.kittySettings = {
    enable = lib.mkEnableOption "Enable Kitty terminal emulator for the user.";
    settings = lib.mkOption {
      type = lib.types.attrs;
      default = {};
      description = "Kitty terminal configuration setttings.";
    };
  };

  config = lib.mkIf config.kittySettings.enable {
    programs.kitty = {
      enable = true;
      package = pkgs.unstable.kitty;
      settings = config.kittySettings.settings;
      shellIntegration.enableZshIntegration = true;
    };
  };
}
