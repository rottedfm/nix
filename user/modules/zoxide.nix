{ config, lib, ... }:

{
  options.zoxideSettings = {
    enable = lib.mkEnableOption "Enable zoxide for the user.";
  };

  config = lib.mkif config.zoxideSettings.enable = {
    programs.zoxide = {
      enable = true;
      enableZshIntegration = true;
    };
  };
}
