# NixOS Configuration - Claude Code Context

This is a modular NixOS configuration flake that manages system and user environments declaratively.

## Repository Purpose

This flake provides a complete NixOS system configuration for the host `fm` with:
- Niri Wayland compositor (primary) and GNOME (secondary)
- DankMaterialShell custom desktop environment
- Hybrid GPU setup (AMD integrated + NVIDIA discrete)
- Home-manager for user-level dotfile management
- Modular architecture separating system and user concerns

## Key Concepts

### Configuration Hierarchy
1. **flake.nix** - Entry point defining all inputs and host configurations
2. **hosts/fm/** - Host-specific configuration for the `fm` machine
3. **modules/nixos/** - System-level NixOS modules (requires root/sudo)
4. **modules/home-manager/** - User-level configurations (no sudo needed)

### State Versions
- NixOS state version: 25.05
- Home Manager state version: 25.05
- Never change these unless explicitly upgrading the system

## Architecture

### Module Organization

**NixOS Modules** (`modules/nixos/`):
- `core/` - Fundamental system configs (boot, networking, audio, users, locale)
- `desktop/` - Display manager, Niri, GNOME configurations
- `services/` - System services (printing, ollama, gaming)

**Home Manager Modules** (`modules/home-manager/`):
- `default.nix` - Main entry point that imports all user modules
- `desktop/` - Niri user settings, GNOME user settings, terminal/wayland tools
- `programs/` - Per-application configurations (git, browsers, editors, etc.)

## Important File Locations

### Window Manager Configuration
- **Niri system config**: `modules/nixos/desktop/niri.nix`
- **Niri user config**: `modules/home-manager/desktop/niri.nix`
  - Window rules, keybindings, layout settings
  - Uses `programs.niri.settings` format for stylix compatibility

### GPU Configuration
- **GPU switching scripts**: `modules/home-manager/programs/gpu-switch.nix`
  - Defines `nvidia-run` command and `nv` alias
  - Sets NVIDIA PRIME offload environment variables
- **Gaming/Steam config**: `modules/nixos/services/gaming.nix`
  - Steam with NVIDIA GPU enforcement

### Display Manager
- **GDM configuration**: `modules/nixos/desktop/display-manager.nix`
  - Login screen, session management
  - Niri and GNOME session support

### Shell Environment
- **DMS integration**: `modules/home-manager/dms.nix`
- **Shell config**: `modules/home-manager/shell.nix`

## Making Changes

### When to edit NixOS modules vs Home Manager modules

**Edit NixOS modules** (`modules/nixos/`) when:
- Installing system-wide packages needed by all users
- Configuring hardware, drivers, kernel modules
- Setting up system services (daemons, servers)
- Modifying boot process, networking, or security settings
- Changes require `sudo nixos-rebuild switch`

**Edit Home Manager modules** (`modules/home-manager/`) when:
- Installing user-specific applications
- Configuring dotfiles and user preferences
- Setting up shell aliases, environment variables
- Customizing application settings (git, editors, terminals)
- Changes apply with `home-manager switch` or next rebuild

### Adding New Modules

**NixOS module**:
1. Create file in appropriate `modules/nixos/` subdirectory
2. Import it in `hosts/fm/default.nix` under the `imports = [...]` list

**Home Manager module**:
1. Create file in appropriate `modules/home-manager/` subdirectory
2. Import it in `modules/home-manager/default.nix`

### Rebuilding the System

```bash
# Full system rebuild (NixOS + home-manager)
sudo nixos-rebuild switch --flake .#fm

# Test without committing (reverts on reboot)
sudo nixos-rebuild test --flake .#fm

# Update flake inputs
nix flake update
nix flake lock --update-input <input-name>
```

## Conventions

### Nix Module Structure
Each module should follow this pattern:
```nix
{ config, lib, pkgs, ... }:

{
  # Configuration here
}
```

### Package Management
- System packages: Add to `environment.systemPackages` in NixOS modules
- User packages: Add to `home.packages` in home-manager modules
- Programs with options: Use `programs.<name>.enable = true` when available

### Window Rules (Niri)
Located in `modules/home-manager/desktop/niri.nix`:
- Use regex patterns for `app-id` matching
- Common properties: `open-floating`, `default-column-width`, `default-window-height`
- WezTerm requires `default-column-width = {}` due to Wayland configure bug

### GPU Usage
- `nv <command>` or `nvidia-run <command>` - Run with NVIDIA GPU
- Steam automatically runs all games on NVIDIA via environment variables
- Commands use NVIDIA PRIME offload (hybrid graphics mode)

## Flake Inputs

Key dependencies:
- `nixpkgs` - Main package repository (unstable channel)
- `home-manager` - User environment management
- `niri` - Scrollable-tiling Wayland compositor
- `nixos-unified` - Simplified config integration
- `dankMaterialShell`, `dms-cli`, `dgop` - Custom shell environment

## Special Considerations

### Stylix Integration
- Niri config uses `programs.niri.settings` format for stylix compatibility
- Wallpaper managed via stylix, spawned with swaybg

### Hybrid Graphics
- System has AMD integrated + NVIDIA discrete GPU
- Uses supergfxctl for GPU mode switching
- Default mode should be hybrid for on-demand NVIDIA usage

### DankMaterialShell
- Custom desktop environment with IPC-based components
- Keybindings in Niri config trigger DMS IPC commands
- Components: spotlight, notepad, notifications, settings, etc.

### Window Manager Behavior
- Niri is a scrollable-tiling compositor (not traditional tiling)
- Windows arranged in columns that scroll horizontally
- Default column width: 0.5 (50% of screen)
- Preset widths: 33%, 50%, 66%

## User Information

- **Username**: rotted
- **Host**: fm
- **Platform**: x86_64-linux
- **Timezone**: America/New_York
- **Primary compositor**: Niri
- **Secondary DE**: GNOME
