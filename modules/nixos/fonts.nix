{ pkgs, ... }:

{
  fonts.packages = with pkgs; [
    noto-fonts-emoji
    noto-fonts-cjk-sans
    jetbrains-mono
    nerdfonts
    font-awesome
  ];

console = {
  colors = [
    # Standard colors (0–7)
    "121212"  # color0 - dark base (slightly lifted from #101010 for legibility)
    "e64747"  # color1 - red (unchanged, solid for errors)
    "50fa7b"  # color2 - green (bright, used for success indicators)
    "ffb86c"  # color3 - yellow/orange (great for warnings)
    "c69fe4"  # color4 - violet-lavender (tweaked from #b294bb for clarity)
    "a473a0"  # color5 - magenta (brighter version of #815f8d for visibility)
    "d1afdd"  # color6 - soft lavender (unchanged)
    "e0e0e0"  # color7 - white/foreground (unchanged)

    # Bright colors (8–15)
    "1f1a1a"  # color8 - brighter black (better contrast vs bg than #201010)
    "ff79c6"  # color9 - bright red/pink (unchanged, key aesthetic)
    "72fba0"  # color10 - light green (slightly boosted from #50fa7b)
    "ffd1a3"  # color11 - soft peach (higher contrast version of #ffb86c)
    "c69fe4"  # color12 - same as color4, repeated for bright blue
    "ffcfff"  # color13 - bright pink (unchanged)
    "e4c9ec"  # color14 - soft violet (tweaked from #d1afdd for separation)
    "ffffff"  # color15 - bright white (slightly boosted from #efefef)
  ];
};

}

