{ pkgs, ... }:

{
  services.playerctld.enable = true;

  home.packages = [ pkgs.termusic ];
}
