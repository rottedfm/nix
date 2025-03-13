{ config, lib, ... }: 

{
  options.localeSettings = {
    enable = lib.mkEnableOption "Enable locale and time zone configuration.";
    timeZone = lib.mkOption {
      type = lib.types.str;
      default = "America/New_York";
      description = "The system time zone.";
    };
    defaultLocale = lib.mkOption {
      type = lib.types.str;
      default = "en_US.UTF-8";
      description = "The default locale for the system.";
    };
    extraLocaleSettings = lib.mkOption {
      type = lib.types.attrsOf lib.types.str;
      default = {
        LC_ADDRESS = "en_US.UTF-8";
        LC_IDENTIFICATION = "en_US.UTF-8";
        LC_MEASUREMENT = "en_US.UTF-8";
        LC_NAME = "en_US.UTF-8";
        LC_NUMERIC = "en_US.UTF-8";
        LC_PAPER = "en_US.UTF-8";
        LC_TELEPHONE = "en_US.UTF-8";
        LC_TIME = "en_US.UTF-8";
      };
    };
  };

  config = lib.mkIf config.localeSettings.enable {
    time.timeZone = config.localeSettings.timeZone;
    i18n.defaultLocale = config.localeSettings.defaultLocale;
    i18n.extraLocaleSettings = config.localeSettings.extraLocaleSettings;
  };
}
