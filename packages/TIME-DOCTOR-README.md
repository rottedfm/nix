# Time Doctor for NixOS

This directory contains three different packaging approaches for Time Doctor. The **FHS environment** (`time-doctor-fhs.nix`) is the recommended approach and is already enabled in your configuration.

## Quick Start

### 1. Rebuild your NixOS configuration

```bash
sudo nixos-rebuild switch --flake ~/.nix#fm
```

### 2. Download Time Doctor

Visit https://2.timedoctor.com/downloads and log in with your Time Doctor account to download the Linux version.

### 3. Install Time Doctor (AppImage - Recommended)

```bash
# Create the directory
mkdir -p ~/.local/share/time-doctor

# Move the downloaded AppImage
mv ~/Downloads/timedoctor-desktop_*_linux-x86_64.AppImage ~/.local/share/time-doctor/TimeDoctorDesktop

# Make it executable
chmod +x ~/.local/share/time-doctor/TimeDoctorDesktop
```

### 4. Launch Time Doctor

```bash
time-doctor
```

Or find it in your application menu.

## Alternative Installation Methods

### Using the .sh Installer

If you downloaded the `.sh` installer instead:

```bash
# Create directory
mkdir -p ~/.local/share/time-doctor

# Run installer
cd ~/.local/share/time-doctor
chmod +x ~/Downloads/td2-ubuntu-interactive-*.sh
~/Downloads/td2-ubuntu-interactive-*.sh
```

Then launch with `time-doctor`.

## Package Options

Three packages are provided in this directory:

1. **time-doctor-fhs.nix** (Currently enabled) - FHS environment wrapper
   - Most reliable for proprietary software
   - Requires manual Time Doctor download
   - Works with both AppImage and installer

2. **time-doctor.nix** - AppImage wrapper
   - Direct AppImage packaging
   - Requires fetchurl update with actual download URL

3. **time-doctor-installer.nix** - Installer wrapper
   - Uses the .sh installer
   - Requires requireFile with manual download

## Troubleshooting

### Screen Sharing Not Working

This is expected! Time Doctor's screen sharing requires special permissions and may not work on:
- Wayland sessions (use X11/Xorg instead)
- NixOS due to sandboxing

The timer functionality should work fine, which is what you need for your employer.

### Running on Wayland

If you're using Wayland (like with niri), you have two options:

1. **Continue using Wayland** - The timer will work, but screen sharing won't
2. **Switch to X11/Xorg** - Full functionality (if needed)

To check your session:
```bash
echo $XDG_SESSION_TYPE
```

### Application Won't Start

Make sure all dependencies are available:

```bash
# Verify the FHS environment
which time-doctor

# Check if files exist
ls -la ~/.local/share/time-doctor/
```

## Notes

- Screen sharing features may not work (OK per your requirements)
- Timer functionality works without issues
- Data is stored in `~/.local/share/time-doctor/`
- Configuration is stored in `~/.config/timedoctor/`

## Updating Time Doctor

To update Time Doctor:

1. Download the new version from https://2.timedoctor.com/downloads
2. Replace the file in `~/.local/share/time-doctor/`
3. Make sure it's executable: `chmod +x ~/.local/share/time-doctor/TimeDoctorDesktop`

## Switching Package Implementations

To use a different package implementation, edit:
`~/.nix/modules/home-manager/programs/time-doctor.nix`

And uncomment the desired package at the top of the file.
