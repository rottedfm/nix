{ config, pkgs, ... }:

{
  # OBS Studio with Wayland support
  programs.obs-studio = {
    enable = true;

    plugins = with pkgs.obs-studio-plugins; [
      # Wayland screen capture support
      obs-pipewire-audio-capture
      obs-vaapi  # Hardware-accelerated encoding
      # obs-vkcapture  # Vulkan/OpenGL game capture
      # wlrobs  # wlroots-based compositor capture (if using sway/river)
    ];
  };

  # Additional packages for OBS
  home.packages = with pkgs; [
    # For virtual camera support
    v4l-utils
  ];
}
