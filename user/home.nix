{ config, pkgs, outputs, inputs, lib,  ... }:

{
  home.username = "rotted";
  home.homeDirectory = "/home/rotted";

  imports = [ ./settings.nix ];

  nixpkgs = {
    overlays = [ outputs.overlays.unstable-packages ];
    config.allowUnfree = true;
  };

  programs.home-manager.enable = true;

  home.stateVersion = "24.11";
}
