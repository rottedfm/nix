{ config, lib, pkgs, ... }:

{
  # User account configuration
  users.users.rotted = {
    isNormalUser = true;
    description = "rotted";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      # Add per-user packages here
      # thunderbird
    ];
  };
}
