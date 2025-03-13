{ config, lib, pkgs, ... }:

{
  options.stylixSettings = {
    enable = lib.mkEnableOption "Enable stylix for the user/system";
    wallpaper = lib.mkOption {
      type = lib.types.path;
      default = ../../wallpapers/sakura-wall.png;
      description = "Stylix's wallpaper path.";
    };
    polarity = lib.mkOption {
      type = lib.types.enum [ "dark" "light" ];
      default = "dark";
      description = "Stylix's polarity mode.";
    };
    fonts = lib.mkOption {
      type = lib.types.attrs;
      default = {
        serif = {
          package = pkgs.dejavu_fonts;
          name = "DeJavu Serif";
        };
        sansSerif = {
          package = pkgs.dejavu_fonts;
          name = "DeJavu Sans";
        };
        monospace = {
          package = pkgs.unstable.nerd-fonts.hack;
          name = "Hack Mono Nerd";
        };
        emoji = {
          package = pkgs.noto-fonts-emoji;
          name = "Noto Color Emoji";
        };
        sizes = {
          applications = 14;
          desktop = 16;
          popups = 16;
          terminal = 14;
        };
      };
      description = "Stylix's font configuration.";
    };
    cursor = lib.mkOption {
      type = lib.types.attrs;
      default = {
        package = pkgs.bibata-cursors;
        name = "Bibata-Modern-Classic";
        size = 24;
      };
      description = "Stylix's cursor settings.";
    };
    opacity = lib.mkOption {
      type = lib.types.attrs;
      default = {
        terminal = 0.75;
      };
      description = "Opacity settings.";
    };
  };

  config = lib.mkIf config.stylixSettings.enable {
    stylix.enable = true;
    stylix.image = config.stylixSettings.wallpaper;
    stylix.polarity = config.stylixSettings.polarity;
    stylix.fonts = config.stylixSettings.fonts;
    stylix.opacity = config.stylixSettings.opacity;
  };
}

