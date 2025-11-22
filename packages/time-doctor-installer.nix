{ pkgs, lib, stdenv, fetchurl, autoPatchelfHook, makeWrapper, ... }:

let
  pname = "time-doctor";
  version = "3.12.77";  # Update this to match your downloaded version

in stdenv.mkDerivation {
  inherit pname version;

  # IMPORTANT: Download the installer from https://2.timedoctor.com/downloads
  # After logging in, download the Ubuntu .sh installer file
  # Then update the URL and hash below

  src = pkgs.requireFile {
    name = "td2-ubuntu-interactive-v${version}.sh";
    url = "https://2.timedoctor.com/downloads";
    sha256 = "0000000000000000000000000000000000000000000000000000";  # Update after download
    message = ''
      Time Doctor installer not found. Please:
      1. Visit https://2.timedoctor.com/downloads
      2. Log in with your Time Doctor account
      3. Download the Ubuntu installer (.sh file)
      4. Add it to the Nix store:

         nix-store --add-fixed sha256 td2-ubuntu-interactive-v${version}.sh

      5. Update the sha256 hash in the package definition
    '';
  };

  dontUnpack = true;
  dontBuild = true;

  nativeBuildInputs = [
    autoPatchelfHook
    makeWrapper
  ];

  buildInputs = with pkgs; [
    stdenv.cc.cc.lib
    libxcb
    xcb-util-image
    xcb-util-cursor
    xcb-util-wm
    xcb-util-keysyms
    libxkbcommon
    xorg.libX11
    xorg.libXext
    xorg.libXrender
    xorg.libXtst
    xorg.libXScrnSaver
    xorg.libxcb
    openssl
    curl
    zlib
    glib
    gtk3
    at-spi2-atk
    at-spi2-core
    cairo
    pango
    gdk-pixbuf
    dbus
    nss
    nspr
    alsa-lib
    cups
    expat
    libdrm
    mesa
  ];

  installPhase = ''
    mkdir -p $out/bin
    mkdir -p $out/opt/time-doctor

    # Copy the installer
    cp $src $out/opt/time-doctor/installer.sh
    chmod +x $out/opt/time-doctor/installer.sh

    # Create a wrapper script
    cat > $out/bin/time-doctor <<EOF
#!/bin/sh
# Time Doctor launcher for NixOS
TIMEDOCTOR_HOME="\$HOME/.local/share/time-doctor"
mkdir -p "\$TIMEDOCTOR_HOME"

# Set up environment
export LD_LIBRARY_PATH="${lib.makeLibraryPath buildInputs}:\$LD_LIBRARY_PATH"

# Check if Time Doctor is installed in user directory
if [ ! -f "\$TIMEDOCTOR_HOME/timedoctor2" ]; then
  echo "Time Doctor not installed. Running installer..."
  echo "This will install Time Doctor to \$TIMEDOCTOR_HOME"
  cd "\$TIMEDOCTOR_HOME"
  ${pkgs.bash}/bin/bash $out/opt/time-doctor/installer.sh
fi

# Launch Time Doctor
cd "\$TIMEDOCTOR_HOME"
exec ./timedoctor2 "\$@"
EOF

    chmod +x $out/bin/time-doctor

    # Create desktop entry
    mkdir -p $out/share/applications
    cat > $out/share/applications/time-doctor.desktop <<EOF
[Desktop Entry]
Name=Time Doctor
Exec=$out/bin/time-doctor
Icon=time-doctor
Type=Application
Categories=Utility;Office;
Comment=Time tracking and productivity monitoring
Terminal=false
StartupWMClass=Time Doctor
EOF
  '';

  meta = with lib; {
    description = "Time tracking and productivity monitoring software";
    homepage = "https://www.timedoctor.com";
    license = licenses.unfree;
    platforms = [ "x86_64-linux" ];
    maintainers = [ ];
  };
}
