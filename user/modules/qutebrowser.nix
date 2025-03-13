{ config, lib, ... }:

{
  options.qutebrowserSettings = {
    enable = lib.mkEnableOption "Enable qutebrowser for the user.";
  };

  config = lib.mkIf config.qutebrowserSettings.enable {
    programs.qutebrowser = {
      enable = true;
    };
  };
}
