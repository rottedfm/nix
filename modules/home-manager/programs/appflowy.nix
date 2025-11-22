{ config, pkgs, ... }:

{
  home.packages = [ pkgs.appflowy pkgs.memos ];
}
