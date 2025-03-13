{ config, lib, pkgs, ...}:

{
  options.gitSettings = {
    enable = lib.mkEnableOption "Enable git for the user."; 
    userName = lib.mkOption {
      type = lib.types.str;
      default = "";
      description = "Username for git commits.";    
    };
    userEmail = lib.mkOption {
      type = lib.types.str; 
      default = "";
      description = "Email for git commits.";
    };
  };

  config = lib.mkIf config.gitSettings.enable {
    programs.git = {
      enable = true;
      userName = config.gitSettings.userName;
      userEmail = config.gitSettings.userEmail;
    };
  };
} 
