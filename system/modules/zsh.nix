{ lib, config, pkgs, ... }:

{
  options.zshSettings = {
    enable = lib.mkEnableOption "Enable Zsh as the default shell.";
    defaultUserShell = lib.mkOption {
      type = lib.types.package;
      default = pkgs.unstable.zsh;
      description = "The default shell for users.";
    };
  };

  config = lib.mkIf config.zshSettings.enable {
    users.defaultUserShell = config.zshSettings.defaultUserShell;

    programs.zsh.enable = true;
  };
}
