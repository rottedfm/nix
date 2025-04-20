{ flake, pkgs, ... }:
let
  inherit (flake) inputs;
  inherit (inputs) self;
  inherit (flake.inputs) niri-flake;
in
{
  imports = [
    self.homeModules.default
  ];

  nixpkgs.overlays = [
    niri-flake.overlays.niri 
  ];

  # Defined by /modules/home/me.nix
  # And used all around in /modules/home/*
  me = {
    username = "rotted";
    fullname = "rottedfm";
    email = "rottedfm@proton.me";
  };

  home.pointerCursor = {
    gtk.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata Modern Classic";
    size = 24;
  };

  home.stateVersion = "24.11";
}
