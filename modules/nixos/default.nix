# This is your nixos configuration.
# For home configuration, see /modules/home/*
{ flake, ... }:
{
  imports = [
    flake.inputs.self.nixosModules.common
    ./amd.nix
    ./xserver.nix
    ./mullvad.nix
    ./stylix.nix
    ./ollama.nix
  ];
  services.openssh.enable = true;
}
