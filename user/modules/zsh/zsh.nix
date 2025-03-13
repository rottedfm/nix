{ config, lib, pkgs, ... }:

{
  options.zshSettings = {
    enable = lib.mkEnableOption "Enable ZSH settings for the user.";
    aliases = lib.mkOption {
      type = lib.types.attrsOf lib.types.str;
      default = {};
      description = "Zsh shell aliases.";
    };
    zshrc = lib.mkOption {
        type = lib.types.str;
        default = "";
        description = "Zshrc config.";
    };
    plugins = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [];
      description = "Zsh plugin manager";
    };
    extraPackages = lib.mkOption {
      type = lib.types.listOf lib.types.package;
      default = [];
      description = "Extra packages to add to the shell environment.";
    };
  };

  config = lib.mkIf config.zshSettings.enable {
    programs.zsh = {
      enable = true;
      shellAliases = config.zshSettings.aliases;
      antidote = {
        enable = true;
        plugins = config.zshSettings.plugins;
      };
      initExtra = config.zshSettings.zshrc;
    };

    home.packages = config.zshSettings.extraPackages;
  };
}
