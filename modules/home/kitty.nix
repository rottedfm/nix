{ ... }:

{
  programs.kitty = {
    enable = true;
    settings = {
      confirm_os_window_close = 0;
      hide_window_decorations = true;
      enable_audio_bell = false;
      window_padding_width = 10;
      background_opacity = 0.1;
      # Colors from Phoenix Dark Pink
      foreground = "#e0e0e0";  # base05
      background = "#101010";  # base00
      selection_background = "#412b3f";  # base03
      selection_foreground = "#e0e0e0";  # base05
      cursor = "#e0e0e0";  # base05
      cursor_text_color = "#101010";  # base00
      url_color = "#b294bb";  # base0D
      # Standard 16-color palette
      color0  = "#101010";  # base00 - black
      color1  = "#e64747";  # base08 - red
      color2  = "#50fa7b";  # base0B - green
      color3  = "#ffb86c";  # base09 - yellow
      color4  = "#b294bb";  # base0D - blue
      color5  = "#815f8d";  # base0E - magenta
      color6  = "#d1afdd";  # base0C - cyan
      color7  = "#e0e0e0";  # base05 - white
      color8  = "#201010";  # base01 - bright black
      color9  = "#ff79c6";  # base0A - bright red
      color10 = "#50fa7b";  # base0B - bright green
      color11 = "#ffb86c";  # base09 - bright yellow
      color12 = "#b294bb";  # base0D - bright blue
      color13 = "#ffcfff";  # base07 - bright magenta
      color14 = "#d1afdd";  # base0C - bright cyan
      color15 = "#efefef";  # base06 - bright white
    };
  };
} 
