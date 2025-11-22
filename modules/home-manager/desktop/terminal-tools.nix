{ config, pkgs, ... }:

{
  programs.kitty = {
    enable = true;

    settings = {
      # Tab bar configuration
      tab_bar_style = "powerline";
      tab_bar_edge = "top";
      tab_bar_min_tabs = 1;

      # Window padding
      window_padding_width = 10;
    };
  };

  programs.zellij.enable = true;
}
