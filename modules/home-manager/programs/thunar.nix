{ config, pkgs, ... }:

{
  # Thunar file manager with multimedia codec support

  home.packages = with pkgs; [
    # File manager
    xfce.thunar
    xfce.thunar-volman        # Removable media manager for Thunar
    xfce.thunar-archive-plugin  # Archive plugin for Thunar

    # Thumbnail support
    xfce.tumbler              # Thumbnail service for Thunar

    # Image codecs and viewers
    gst_all_1.gst-plugins-base
    gst_all_1.gst-plugins-good
    gst_all_1.gst-plugins-bad
    gst_all_1.gst-plugins-ugly
    gst_all_1.gst-libav       # FFmpeg-based GStreamer plugins

    # Video codecs
    ffmpeg-full               # Complete FFmpeg suite
    libheif                   # HEIF/HEIC image support

    # Additional multimedia support
    glib                      # For GIO thumbnails
    shared-mime-info          # MIME type database

    # Image format support
    webp-pixbuf-loader        # WebP image support
    librsvg                   # SVG support
  ];

  # Enable thumbnailing for various file types
  xdg.mimeApps = {
    enable = true;
  };

  # Force overwrite existing mimeapps.list
  xdg.configFile."mimeapps.list".force = true;

  # Thunar configuration
  xdg.configFile."Thunar/uca.xml".text = ''
    <?xml version="1.0" encoding="UTF-8"?>
    <actions>
    </actions>
  '';
}
