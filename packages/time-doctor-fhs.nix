{ pkgs, lib, ... }:

# This creates an FHS-compatible environment for running Time Doctor
# This is the most reliable method for proprietary software on NixOS

pkgs.buildFHSEnv {
  name = "time-doctor";

  targetPkgs = pkgs: with pkgs; [
    # Core system libraries
    stdenv.cc.cc.lib
    glibc

    # X11 and display libraries
    xorg.libX11
    xorg.libXext
    xorg.libXrender
    xorg.libXtst
    xorg.libXScrnSaver
    xorg.libxcb
    xorg.libXcomposite
    xorg.libXdamage
    xorg.libXfixes
    xorg.libXrandr
    xorg.libXi
    xorg.libXcursor
    xorg.libxshmfence

    # XCB libraries (required by Time Doctor)
    libxcb
    xorg.xcbutilimage
    xorg.xcbutilcursor
    xorg.xcbutilwm
    xorg.xcbutilkeysyms
    xorg.xcbutilrenderutil

    # GTK and desktop integration
    gtk3
    glib
    cairo
    pango
    gdk-pixbuf
    atk
    at-spi2-atk
    at-spi2-core
    dbus

    # Qt6 libraries
    qt6.qtbase
    qt6.qtwayland

    # Additional libraries
    libxkbcommon
    xorg.libxkbfile
    wayland
    openssl
    curl
    zlib
    nss
    nspr
    alsa-lib
    cups
    expat
    libdrm
    mesa
    libglvnd
    libGL
    fontconfig
    freetype
    xorg.libSM
    xorg.libICE
    xkeyboard_config

    # Utilities
    bash
    coreutils
    which
    procps
    systemd
    util-linux
  ];

  multiPkgs = pkgs: with pkgs; [
    # 32-bit compatibility if needed
  ];

  # Run the Time Doctor executable with proper environment
  runScript = pkgs.writeShellScript "time-doctor-wrapper" ''
    TIMEDOCTOR_DIR="$HOME/.local/share/time-doctor"

    # Check if Time Doctor is installed
    if [ ! -f "$TIMEDOCTOR_DIR/timedoctor" ]; then
      echo "============================================"
      echo "Time Doctor Installation Required"
      echo "============================================"
      echo ""
      echo "Please download Time Doctor from:"
      echo "https://2.timedoctor.com/downloads"
      echo ""
      echo "Installation steps:"
      echo "   - Download the .sh installer"
      echo "   - chmod +x td2-ubuntu-interactive-*.sh"
      echo "   - Run the installer (it will install to ~/.local/share/time-doctor)"
      echo ""
      echo "After installation, run 'time-doctor' again."
      echo "============================================"
      exit 1
    fi

    # Change to Time Doctor directory
    cd "$TIMEDOCTOR_DIR"

    # Set up Qt plugin path to use ONLY Time Doctor's bundled Qt6 plugins
    # Don't mix with system Qt to avoid version conflicts
    export QT_PLUGIN_PATH="$TIMEDOCTOR_DIR/3.16.69/Qt6/plugins"
    export QT_QPA_PLATFORM_PLUGIN_PATH="$TIMEDOCTOR_DIR/3.16.69/Qt6/plugins/platforms"

    # Set library path to include Time Doctor's bundled libraries FIRST
    export LD_LIBRARY_PATH="$TIMEDOCTOR_DIR/3.16.69/lib:''${LD_LIBRARY_PATH:-}"

    # Use xcb platform (X11) since Wayland might not work well with screen tracking
    export QT_QPA_PLATFORM="xcb"

    # Disable GPU acceleration to work around OpenGL issues
    export QT_XCB_GL_INTEGRATION="none"
    export QTWEBENGINE_DISABLE_SANDBOX=1

    # Set XKB config path
    export XKB_CONFIG_ROOT="${pkgs.xkeyboard_config}/share/X11/xkb"

    # Point to loginctl in FHS environment
    export PATH="/usr/bin:$PATH"

    # Run Time Doctor
    exec ./timedoctor "$@"
  '';

  meta = with lib; {
    description = "FHS environment for running Time Doctor on NixOS";
    longDescription = ''
      This package provides an FHS-compatible environment for running Time Doctor.
      You need to manually download and install Time Doctor from:
      https://2.timedoctor.com/downloads

      The application will be installed to ~/.local/share/time-doctor/

      Note: Screen sharing features may not work on Wayland.
      Use X11/Xorg for full functionality.
    '';
    homepage = "https://www.timedoctor.com";
    license = licenses.unfree;
    platforms = [ "x86_64-linux" ];
  };
}
