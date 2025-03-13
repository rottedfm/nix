{ lib, config, pkgs, ... }:

{
  options.soundSettings = {
    enable = lib.mkEnableOption "Enable sound services (Pipwire and RTKit).";
    enable32BitAlsa = lib.mkEnableOption "Enable 32-bit ALSA support.";
  };

  config = lib.mkIf config.soundSettings.enable {
    # enable RTKit
    security.rtkit.enable = true;

    # enable pipewire and configure sound support
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = config.soundSettings.enable32BitAlsa;
      pulse.enable = true;
    };

    environment.systemPackages = [ pkgs.alsa-utils ];
  };
}
