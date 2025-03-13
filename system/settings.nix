{ config, pkgs, ... }:

{
  imports = [
    # bootloader
    ./modules/boot.nix
    # GPU
    ./modules/gpu.nix
    # hyprland
    ./modules/hyprland.nix
    # locale
    ./modules/locale.nix
    # network
    ./modules/network.nix
    # ollama
    ./modules/ollama.nix
    # sound
    ./modules/sound.nix
    # stylix 
    ./modules/stylix.nix
    # zsh 
    ./modules/zsh.nix
  ];

  # bootloader 
  bootSettings = {
    enableAutoLogin = true;
    enableSystemdBoot = true;
  };

  # gpu
  gpuSettings = {
    enable = true;
    driver = "amd";
  };

  # hyprland
  hyprlandSettings = {
    enable = true;
  };

  # locale
  localeSettings = {
    enable = true;
    timeZone = "America/New_York";
    defaultLocale = "en_US.UTF-8";
  };

  # network
  networkSettings = {
    enable = true;
    hostName = "fm";
    enableNetworkManager = true;
  };

  # ollama
  ollamaSettings = {
    enable = true;
    acceleration = "rocm";
  };

  # sound
  soundSettings = {
    enable = true;
    enable32BitAlsa = true;
  };  

  # stylix
  stylixSettings = {
    enable = true;
    wallpaper = ../wallpapers/sakura-wall.png;
    polarity = "dark";
  };

  # zsh 
  zshSettings = {
    enable = true;
  };
  
}
