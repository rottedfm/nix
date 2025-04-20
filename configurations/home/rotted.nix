{ flake, pkgs, niri, ... }:
let
  inherit (flake) inputs;
  inherit (inputs) self;
in
{
  imports = [
    self.homeModules.default
  ];

  nixpkgs.overlays = [
    niri.overlays.niri 
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
