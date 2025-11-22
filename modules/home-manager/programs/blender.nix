{ config, pkgs, ... }:

{
  # Blender - 3D creation suite
  home.packages = with pkgs; [
    blender
  ];
}
