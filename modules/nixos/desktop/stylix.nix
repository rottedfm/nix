{ config, pkgs, lib, ... }:

{
  # Stylix system-wide theming configuration
  # Using DankMaterialShell + niri, NOT GNOME Shell
  # Stylix will theme: Qt apps, terminals, editors, display managers, etc.

  # Icon fonts - Font Awesome and other common icon fonts
  # These provide icon glyphs for UI elements, status bars, etc.
  fonts.packages = with pkgs; [
    # Font Awesome - most popular icon font (v6)
    font-awesome

    # Material Design Icons - Google's material design icons
    material-design-icons

    # Nerd Fonts - includes Font Awesome, Material Icons, and many more
    # Popular variants with icon support:
    # Note: nerdfonts has been split into individual packages (nerd-fonts.*)
    nerd-fonts.fira-code
    nerd-fonts.jetbrains-mono
    nerd-fonts.iosevka
    nerd-fonts.hack
  ];

  stylix = {
    enable = true;

    # Base16 color scheme - using custom Ferra theme
    # Ferra: A warm, earthy theme inspired by Kanagawa and Gruvbox
    # GitHub: https://github.com/casperstorm/ferra
    base16Scheme = ../../../themes/ferra.yaml;

    # Wallpaper - stylix will generate a color scheme from this if base16Scheme is not set
    # Replace with your preferred wallpaper path
    image = ../../../Wallpapers/starry-astronomy-night-4k-2k.jpg;

    # Polarity - "dark" or "light" theme
    # This will bias the generated color scheme toward dark or light themes
    polarity = "dark";

    # Font configuration
    fonts = {
      serif = {
        package = pkgs.dejavu_fonts;
        name = "DejaVu Serif";
      };

      sansSerif = {
        package = pkgs.dejavu_fonts;
        name = "DejaVu Sans";
      };

      monospace = {
        package = pkgs.dejavu_fonts;
        name = "DejaVu Sans Mono";
      };

      emoji = {
        package = pkgs.noto-fonts-color-emoji;
        name = "Noto Color Emoji";
      };

      sizes = {
        applications = 13;
        terminal = 13;
        desktop = 10;
        popups = 10;
      };
    };

    # Cursor theme
    cursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Classic";
      size = 24;
    };

    # Opacity settings
    opacity = {
      applications = 1.0;
      terminal = 0.7;
      desktop = 1.0;
      popups = 1.0;
    };

    # Target-specific configuration
    targets = {
      # Qt theming - for Qt applications
      qt = {
        enable = true;
        platform = lib.mkForce "qtct";  # Use qtct (Qt Configuration Tool) for Qt theming
      };

      # Disable GTK theming
      gtk.enable = false;

      # Disable GNOME Shell theming - we're using DankMaterialShell + niri, not GNOME Shell
      gnome.enable = false;
    };
  };
}
