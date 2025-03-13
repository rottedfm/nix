{ inputs, outputs, config, pkgs, lib, ... }:

{
  imports = [
    ./settings.nix
    ./hardware-configuration.nix
  ];

  nixpkgs = {
    overlays = [ outputs.overlays.unstable-packages ];

    config = { allowUnfree = true; };
  };

  nix = let flakeInputs = lib.filterAttrs (_: lib.isType "flake") inputs;
    in {
      settings = {
        # enable flakes
        experimental-features = [ "nix-command" "flakes" ];

        # disable flake registry
        flake-registry = "";

        # workaround for https://github.com/NixOS/nix/issues/9574
        nix-path = config.nix.nixPath;
      };

      # turn of channels
      channel.enable = false;

      # make flake registry and nix path match flake inputs
      registry = lib.mapAttrs (_: flake: {inherit flake; }) flakeInputs;
      nixPath = lib.mapAttrsToList (n: _: "${n}=flake:${n}") flakeInputs;
    };    

    users.users.rotted = {
      isNormalUser = true;
      description = "rotted";
      extraGroups = [ "networkmanager" "wheel" ];
      packages = with pkgs; [ ];
    };

    system.stateVersion = "24.11";
}
