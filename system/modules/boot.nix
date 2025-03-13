{ config, pkgs, lib, ...}:

{
  options.bootSettings = {
    enableSystemdBoot = lib.mkEnableOption "Enable systemd-boot as the bootloader.";
    enableAutoLogin = lib.mkEnableOption "Enable getty auto-login for a specific user.";
  };

  config = {
    boot.loader.systemd-boot.enable = config.bootSettings.enableSystemdBoot;
    boot.loader.efi.canTouchEfiVariables = lib.mkIf config.bootSettings.enableSystemdBoot true;

    # Always set auto-login for user "rotted"
    services.getty.autologinUser = lib.mkIf config.bootSettings.enableAutoLogin "rotted";
  };
}
