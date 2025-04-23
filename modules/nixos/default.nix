# This is your nixos configuration.
# For home configuration, see /modules/home/*
{ flake, ... }:
{
  imports = [
    flake.inputs.self.nixosModules.common
    ./amd.nix
    ./xserver.nix
    ./mullvad.nix
    ./gpg.nix
    ./ollama.nix
    ./zsh.nix
    ./bluetooth.nix
    ./sound.nix
    ./fonts.nix
    ./steam.nix
    ./gamescope.nix
  ];
  services.openssh.enable = true;
}
