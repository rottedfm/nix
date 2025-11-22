{ config, pkgs, lib, ... }:

let
  # Import the Time Doctor FHS package
  # This is the recommended approach for proprietary software on NixOS
  time-doctor = pkgs.callPackage ../../../packages/time-doctor-fhs.nix { };

  # Alternative packages (uncomment to use):
  # time-doctor-appimage = pkgs.callPackage ../../../packages/time-doctor.nix { };
  # time-doctor-installer = pkgs.callPackage ../../../packages/time-doctor-installer.nix { };

in
{
  # Time Doctor time tracking software
  # Required by employer for time tracking
  #
  # Installation steps:
  # 1. Download Time Doctor from https://2.timedoctor.com/downloads (login required)
  # 2. Save the AppImage to ~/.local/share/time-doctor/TimeDoctorDesktop
  # 3. Run: chmod +x ~/.local/share/time-doctor/TimeDoctorDesktop
  # 4. Launch with: time-doctor
  #
  # Note: Screen sharing may not work on Wayland. Use X11/Xorg session if needed.
  # The timer functionality should work without issues.

  home.packages = [
    time-doctor
  ];

  # Optional: Create a desktop entry for easy launching
  xdg.desktopEntries.time-doctor = {
    name = "Time Doctor";
    genericName = "Time Tracking";
    comment = "Employee time tracking and productivity monitoring";
    exec = "time-doctor";
    icon = "time-doctor";
    terminal = false;
    categories = [ "Utility" "Office" ];
    settings = {
      StartupWMClass = "Time Doctor";
    };
  };
}
