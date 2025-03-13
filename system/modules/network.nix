{ config, lib, ... }:

{
  options.networkSettings = {
    enable = lib.mkEnableOption "Enable network configuration";
    hostName = lib.mkOption {
      type = lib.types.str;
      default = "fm";
      description = "The hostname of the system.";
    };
    enableNetworkManager = lib.mkEnableOption "Enable NetworkManager for managing network connections.";
  };

  config = lib.mkIf config.networkSettings.enable {
    # hostname configuration
    networking.hostName = config.networkSettings.hostName;

    # network manager configuration
    networking.networkmanager.enable = config.networkSettings.enableNetworkManager;
  };
}
