{ config, pkgs, lib, ... }:

{
  options.bootSettings = {
    enableSystemdBoot = lib.mkEnableOption "Enable systemd-boot as the bootloader.";
    enableAutoLogin = lib.mkEnableOption "Enable getty auto-login for a specific user.";
    autoLoginUser = lib.mkOption {
      type = lib.types.str;
      default = "rotted";
      description = "The username to use for getty auto-login.";
    };
  };

  config = {
    boot.loader.systemd-boot.enable = config.bootSettings.enableSystemdBoot;
    boot.loader.efi.canTouchEfiVariables = lib.mkIf config.bootSettings.enableSystemdBoot true;

    services.getty.autologinUser = lib.mkIf config.bootSettings.enableAutoLogin config.bootSettings.autoLoginUser;
  };
}
