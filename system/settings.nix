{ config, pkgs, ... }:

{
  imports = [
    ./modules/boot.nix
    ./modules/gpu.nix
    ./modules/hyprland.nix
    ./modules/locale.nix
    ./modules/network.nix
    ./modules/ollama.nix
    ./modules/sound.nix
    ./modules/stylix.nix
    ./modules/zsh.nix
  ];

  bootSettings = {
    enableAutoLogin = true;
    enableSystemdBoot = true;
  };

  gpuSettings = {
    enable = true;
    driver = "NVIDIA";
  };


  hyprlandSettings = {
    enable = true;
  };

  localeSettings = {
    enable = true;
    timeZone = "America/New_York";
    defaultLocale = "en_US.UTF-8";
  };

  networkSettings = {
    enable = true;
    hostName = "fm";
    enableNetworkManager = true;
  };

  # ollamaSettings = {
  #   enable = true;
  #   acceleration = "cuda";
  # };

  soundSettings = {
    enable = true;
    enable32BitAlsa = true;
  };

  stylixSettings = {
    enable = true;
    wallpaper = ../wallpapers/sakura-wall.png;
    polarity = "dark";
  };

  zshSettings = {
    enable = true;
  };
}
