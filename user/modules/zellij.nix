{ config, lib, pkgs, ... }:

{
  options.zellijSettings = {
    enable = lib.mkEnableOption "Enable zellij for the user.";
    settings = lib.mkOption {
      type = lib.types.attrs;
      default = {};
      description = "Enable zellij configuration settings.";
    };
  };

  config = lib.mkIf config.zellijSettings.enable {
    programs.zellij = {
      enable = true;
      enableZshIntegration = true;
      package = pkgs.unstable.zellij;
      settings = config.zellijSettings.settings;
    };
  };
}
