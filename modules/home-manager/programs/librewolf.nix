{ config, lib, pkgs, ... }:

{
  programs.librewolf = {
    enable = true;

    # Declare your profiles
    profiles = {
      default = {
        id = 0;
        isDefault = true;
        # You can add other settings here like extensions, search engines, etc.
      };
    };
  };

  # Configure stylix to theme librewolf with the profile names
  stylix.targets.librewolf.profileNames = [ "default" ];
}
