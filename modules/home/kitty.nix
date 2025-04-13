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
      cursor_text_color = "#";  # base00
      url_color = "#b294bb";  # base0D
      # Standard 16-color palette
      color1 = "121212";  # color0 - dark base (slightly lifted from #101010 for legibility)
      color2 = "e64747";  # color1 - red (unchanged, solid for errors)
      color3 = "50fa7b";  # color2 - green (bright, used for success indicators)
      color4 = "ffb86c";  # color3 - yellow/orange (great for warnings)
      color5 = "c69fe4";  # color4 - violet-lavender (tweaked from #b294bb for clarity)
      color6 = "a473a0";  # color5 - magenta (brighter version of #815f8d for visibility)
      color7 = "d1afdd";  # color6 - soft lavender (unchanged)
      color8 = "e0e0e0";  # color7 - white/foreground (unchanged)

    # Bright colors (8–15)
      color9 = "1f1a1a";  # color8 - brighter black (better contrast vs bg than #201010)
      color10 = "ff79c6";  # color9 - bright red/pink (unchanged, key aesthetic)
      color11 = "72fba0";  # color10 - light green (slightly boosted from #50fa7b)
      color12 = "ffd1a3";  # color11 - soft peach (higher contrast version of #ffb86c)
      color13 = "c69fe4";  # color12 - same as color4, repeated for bright blue
      color14 = "ffcfff";  # color13 - bright pink (unchanged)
      color15 = "e4c9ec";  # color14 - soft violet (tweaked from #d1afdd for separation)
      color16 = "ffffff";  # color15 - bright white (slightly boosted from #efefef)

    };
  };
} 
