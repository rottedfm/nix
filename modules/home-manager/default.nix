{ config, lib, pkgs, ... }:

{
  imports = [
    # Shell configuration
    ./shell.nix

    # Program modules
    ./programs/git.nix
    ./programs/gpg.nix
    ./programs/librewolf.nix
    ./programs/claude-code.nix
    ./programs/editors.nix
    ./programs/browsers.nix
    ./programs/appflowy.nix
    ./programs/slack.nix
    ./programs/gpu-switch.nix
    ./programs/thunar.nix
    ./programs/mpv.nix
    ./programs/libreoffice.nix
    ./programs/time-doctor.nix
    ./programs/security.nix
    ./programs/obs.nix
    ./programs/blender.nix
    ./programs/torrenting.nix

    # Desktop environment modules
    ./desktop/terminal-tools.nix
    ./desktop/wayland-tools.nix
    ./desktop/noctalia-shell.nix
  ];
}
