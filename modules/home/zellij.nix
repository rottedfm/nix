{ ... }:

let
  phoenixDarkPinkTheme = ''
    themes {
      phoenix-dark-pink {
        fg "#e0e0e0"
        bg "#101010"
        black "#101010"
        red "#e64747"
        green "#50fa7b"
        yellow "#ffb86c"
        blue "#b294bb"
        magenta "#815f8d"
        cyan "#d1afdd"
        white "#e0e0e0"
        orange "#ff79c6"
        gray "#201010"
        dark-gray "#31182d"
        light-gray "#efefef"
        bg-alt "#201010"
      }
    }
  '';
in
{
  programs.zellij = {
    enable = true;
    enableZshIntegration = true;

    settings = {
      theme = "phoenix-dark-pink";
    };
  };

  home.file."config/zellij/themes/phoenix-dark-pink.kdl".text = phoenixDarkPinkTheme;
}
