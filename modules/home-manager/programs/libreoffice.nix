{ config, pkgs, ... }:

{
  # LibreOffice office suite

  home.packages = with pkgs; [
    libreoffice-fresh  # Latest LibreOffice version with all features
  ];
}
