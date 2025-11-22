{ pkgs, lib, fetchurl, appimageTools, ... }:

let
  pname = "time-doctor";
  version = "3.12.77";  # Update this as needed

  # Download Time Doctor from https://2.timedoctor.com/downloads
  # You'll need to log in and download the AppImage manually
  # Then either:
  # 1. Place it in /nix/store and update the hash
  # 2. Or use requireFile (see commented alternative below)

  src = fetchurl {
    # Note: This URL is a placeholder. Time Doctor requires authentication to download.
    # Option 1: Download manually from https://2.timedoctor.com/downloads
    #           and use requireFile (see commented code below)
    # Option 2: If you have a direct download link, update this URL
    url = "https://2.timedoctor.com/downloads/timedoctor-desktop_${version}_linux-x86_64.AppImage";
    sha256 = lib.fakeSha256;  # Update after first build attempt
    # To get the correct hash:
    # 1. Try to build with fakeSha256
    # 2. Nix will show the actual hash in the error message
    # 3. Replace fakeSha256 with that hash
  };

  # Alternative: Use requireFile for manual download
  # Uncomment this and comment out the fetchurl above if you prefer
  # src = pkgs.requireFile {
  #   name = "timedoctor-desktop_${version}_linux-x86_64.AppImage";
  #   url = "https://2.timedoctor.com/downloads";
  #   sha256 = "0000000000000000000000000000000000000000000000000000";
  #   message = ''
  #     Time Doctor requires authentication to download.
  #     Please download the AppImage from https://2.timedoctor.com/downloads
  #     and add it to the Nix store:
  #
  #     nix-store --add-fixed sha256 timedoctor-desktop_${version}_linux-x86_64.AppImage
  #   '';
  # };

  appimageContents = appimageTools.extractType2 {
    inherit pname version src;
  };

in appimageTools.wrapType2 {
  inherit pname version src;

  extraInstallCommands = ''
    # Install desktop file and icon
    mkdir -p $out/share/applications
    mkdir -p $out/share/pixmaps

    # Copy desktop file if it exists in the AppImage
    if [ -f ${appimageContents}/time-doctor.desktop ]; then
      cp ${appimageContents}/time-doctor.desktop $out/share/applications/
    elif [ -f ${appimageContents}/timedoctor.desktop ]; then
      cp ${appimageContents}/timedoctor.desktop $out/share/applications/
    else
      # Create a desktop file if not included
      cat > $out/share/applications/time-doctor.desktop <<EOF
[Desktop Entry]
Name=Time Doctor
Exec=${pname}
Icon=time-doctor
Type=Application
Categories=Utility;Office;
Comment=Time tracking and productivity monitoring
Terminal=false
EOF
    fi

    # Update Exec path in desktop file to use the wrapper
    sed -i "s|Exec=.*|Exec=$out/bin/${pname}|g" $out/share/applications/*.desktop

    # Copy icon if it exists
    if [ -f ${appimageContents}/time-doctor.png ]; then
      cp ${appimageContents}/time-doctor.png $out/share/pixmaps/
    elif [ -f ${appimageContents}/timedoctor.png ]; then
      cp ${appimageContents}/timedoctor.png $out/share/pixmaps/time-doctor.png
    fi
  '';

  # Add extra packages that Time Doctor might need
  extraPkgs = pkgs: with pkgs; [
    libxcb
    xcb-util-image
    xcb-util-cursor
    xcb-util-wm
    xcb-util-keysyms
    xcb-util-renderutil
    libxkbcommon
    xorg.libX11
    xorg.libXext
    xorg.libXrender
    xorg.libXtst
    xorg.libXScrnSaver
  ];

  meta = with lib; {
    description = "Time tracking and productivity monitoring software";
    homepage = "https://www.timedoctor.com";
    license = licenses.unfree;
    platforms = [ "x86_64-linux" ];
    maintainers = [ ];
  };
}
