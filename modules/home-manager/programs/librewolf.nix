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
}
