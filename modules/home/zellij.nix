{ ... }:

{
  programs.zellij = {
    enable = true;
    enableZshIntegration = true;

    settings = {
      theme = "phoenix-dark-pink";

      themes."phoenix-dark-pink" = {
        fg = "#e0e0e0";       # base05
        bg = "#101010";       # base00
        black = "#101010";    # base00
        red = "#e64747";      # base08
        green = "#50fa7b";    # base0B
        yellow = "#ffb86c";   # base09
        blue = "#b294bb";     # base0D
        magenta = "#815f8d";  # base0E
        cyan = "#d1afdd";     # base0C
        white = "#e0e0e0";    # base05
        orange = "#ff79c6";   # base0A
        gray = "#201010";     # base01
        "dark-gray" = "#31182d"; # base02
        "light-gray" = "#efefef"; # base06
        "bg-alt" = "#201010"; # base01
      };
    };
  };
}
