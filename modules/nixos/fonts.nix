{ pkgs, ... }:

{
  fonts.packages = with pkgs; [
    noto-fonts-emoji
    noto-fonts-cjk-sans
    nerd-fonts.jetbrains-mono
  ];


  console = {
    font = "ter-v32b";
    earlySetup = true;
      colors = {
      background = "#101010"; # base00
      foreground = "#e0e0e0"; # base05
      color0  = "#101010";    # black   (base00)
      color1  = "#e64747";    # red     (base08)
      color2  = "#50fa7b";    # green   (base0B)
      color3  = "#ffb86c";    # yellow  (base09)
      color4  = "#b294bb";    # blue    (base0D)
      color5  = "#815f8d";    # magenta (base0E)
      color6  = "#d1afdd";    # cyan    (base0C)
      color7  = "#e0e0e0";    # white   (base05)
      color8  = "#201010";    # br.black (base01)
      color9  = "#ff79c6";    # br.red   (base0A)
      color10 = "#50fa7b";    # br.green (base0B)
      color11 = "#ffb86c";    # br.yellow(base09)
      color12 = "#b294bb";    # br.blue  (base0D)
      color13 = "#ffcfff";    # br.magenta (base07)
      color14 = "#d1afdd";    # br.cyan  (base0C)
      color15 = "#efefef";    # br.white (base06)
    };
  };
}

