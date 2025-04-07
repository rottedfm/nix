{ pkgs, ... }:

{
  fonts.packages = with pkgs; [
    noto-fonts-color
    noto-fonts-cjk-sans
    nerd-fonts.jetbrains-mono
  ];
}

