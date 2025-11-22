
{ pkgs, config, inputs, lib, ... }:

let
  # Generate DankMaterialShell theme from stylix colors
  # Base16 to Material Design 3 color mapping for dark theme
  stylixColors = config.lib.stylix.colors.withHashtag;

  dmsTheme = pkgs.writeText "dms-stylix-theme.json" (builtins.toJSON {
    dark = {
      # Primary colors - using base0D (blue accent)
      primary = stylixColors.base0D;
      primaryText = stylixColors.base00;
      primaryContainer = stylixColors.base0D;

      # Secondary colors - using base0E (purple/magenta accent)
      secondary = stylixColors.base0E;
      surfaceTint = stylixColors.base0D;

      # Surface colors - using base00-base03 gradients
      surface = stylixColors.base01;
      surfaceText = stylixColors.base05;
      surfaceVariant = stylixColors.base02;
      surfaceVariantText = stylixColors.base05;
      surfaceContainer = stylixColors.base01;
      surfaceContainerHigh = stylixColors.base02;
      surfaceContainerHighest = stylixColors.base03;

      # Background colors
      background = stylixColors.base00;
      backgroundText = stylixColors.base05;

      # Outline color
      outline = stylixColors.base03;

      # Semantic colors - using base16 accent colors
      error = stylixColors.base08;    # Red
      warning = stylixColors.base0A;  # Yellow
      info = stylixColors.base0C;     # Cyan
    };
  });
in
{
  # Import DankMaterialShell modules
  imports = [
    inputs.dankMaterialShell.homeModules.dankMaterialShell.default
    inputs.dankMaterialShell.homeModules.dankMaterialShell.niri
  ];

  # Enable DankMaterialShell
  # NOTE: enableDynamicTheming disabled to allow stylix to handle all theming
  programs.dankMaterialShell = {
    enable = true;
    systemd.enable = true;
    enableSystemMonitoring = true;
    enableVPN = true;
    enableBrightnessControl = true;
    enableColorPicker = true;
    enableDynamicTheming = false;  # Disabled - stylix handles theming
    enableAudioWavelength = true;
    enableSystemSound = true;
    niri = {
      enableKeybinds = false;
    };
  };

  # Configure DankMaterialShell to use stylix-generated theme
  home.file.".config/DankMaterialShell/stylix-theme.json".source = dmsTheme;

  # Override settings.json to use custom stylix theme
  home.file.".config/DankMaterialShell/settings.json" = {
    text = builtins.toJSON {
      currentThemeName = "custom";
      customThemeFile = "${config.home.homeDirectory}/.config/DankMaterialShell/stylix-theme.json";
    };
    # Force overwrite to apply stylix theme changes
    force = true;
  };
}
