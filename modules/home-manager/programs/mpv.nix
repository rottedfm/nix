{ config, pkgs, ... }:

{
  programs.mpv = {
    enable = true;

    # Optional: Add some useful configuration
    config = {
      # Hardware acceleration
      hwdec = "auto";

      # Better video quality
      profile = "gpu-hq";

      # UI settings
      osd-level = 1;
      osd-duration = 2500;

      # Audio
      volume = 100;
      volume-max = 150;
    };

    # Optional: Add useful scripts
    scripts = with pkgs.mpvScripts; [
      mpris           # Media player controls integration
      thumbfast       # High-performance on-the-fly thumbnailer
    ];
  };
}
