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
    ./xmrig.nix
    ./bluetooth.nix
    ./sound.nix
  ];
  services.openssh.enable = true;
}
