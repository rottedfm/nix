# NixOS Configuration Flake

A modular NixOS configuration using flakes, home-manager, and nixos-unified for declarative system management.

## Overview

This flake manages NixOS system configurations with a clean, modular architecture that separates concerns between system-level (NixOS) and user-level (home-manager) configurations. It uses `nixos-unified` for simplified configuration management and supports the Niri Wayland compositor alongside GNOME.

## Directory Structure

```
.
├── flake.nix                    # Main flake configuration
├── flake.lock                   # Locked dependency versions
├── hosts/                       # Host-specific configurations
│   └── fm/
│       ├── default.nix          # Main host configuration
│       └── hardware-configuration.nix
└── modules/
    ├── nixos/                   # NixOS system modules
    │   ├── core/                # Core system settings
    │   ├── desktop/             # Desktop environment configs
    │   └── services/            # System services
    └── home-manager/            # User-level configurations
        ├── default.nix          # Main home-manager entry
        ├── desktop/             # Desktop user tools
        └── programs/            # Application configurations
```

## Flake Inputs

### Core Dependencies
- **nixpkgs**: NixOS unstable channel
- **home-manager**: Declarative dotfile and user environment management
- **flake-parts**: Modular flake framework
- **nixos-unified**: Simplified NixOS + home-manager integration

### Desktop Environment
- **niri**: Scrollable-tiling Wayland compositor

### Custom Shells
- **dgop**: DankMaterialShell dependency
- **dms-cli**: DankLinux CLI tools
- **dankMaterialShell**: Custom shell environment

## Host Configurations

### fm (flake.nix:39)
- **Platform**: x86_64-linux
- **User**: rotted
- **Location**: `./hosts/fm/`
- **Features**:
  - Latest Linux kernel
  - Timezone: America/New_York
  - Niri compositor support
  - Full home-manager integration

## Module Organization

### NixOS Modules (`modules/nixos/`)

#### Core System (`core/`)
Fundamental system configuration:
- `boot.nix` - Boot loader and kernel settings
- `networking.nix` - Network configuration
- `locale.nix` - Localization settings
- `audio.nix` - Audio system (PipeWire/PulseAudio)
- `users.nix` - User account management
- `system.nix` - General system settings

#### Desktop Environment (`desktop/`)
Graphical environment setup:
- `display-manager.nix` - Login manager configuration
- `niri.nix` - Niri compositor settings
- `gnome.nix` - GNOME desktop environment

#### Services (`services/`)
System-level services:
- `printing.nix` - CUPS printing support
- `ollama.nix` - Ollama AI service
- `gaming.nix` - Gaming-related services

### Home Manager Modules (`modules/home-manager/`)

#### Shell Environment
- `shell.nix` - Shell configuration
- `dms.nix` - DankMaterialShell integration

#### Programs (`programs/`)
Application-specific configurations:
- `git.nix` - Git version control
- `librewolf.nix` - Privacy-focused browser
- `browsers.nix` - General browser configs
- `claude-code.nix` - Claude Code editor
- `editors.nix` - Text editor configurations
- `logseq.nix` - Knowledge management
- `slack.nix` - Team communication

#### Desktop Tools (`desktop/`)
User-level desktop utilities:
- `niri.nix` - User-specific Niri settings
- `gnome.nix` - User-specific GNOME settings
- `terminal-tools.nix` - Terminal utilities
- `wayland-tools.nix` - Wayland-specific tools

## Usage

### Building the System

```bash
# Rebuild NixOS configuration
sudo nixos-rebuild switch --flake .#fm

# Build without activating
sudo nixos-rebuild build --flake .#fm

# Test configuration (reverts on reboot)
sudo nixos-rebuild test --flake .#fm
```

### Updating Dependencies

```bash
# Update all inputs
nix flake update

# Update specific input
nix flake lock --update-input nixpkgs
```

### Adding a New Host

1. Create directory: `mkdir -p hosts/<hostname>`
2. Add `default.nix` and `hardware-configuration.nix`
3. Add configuration to `flake.nix`:
   ```nix
   nixosConfigurations."<hostname>" =
     self.nixos-unified.lib.mkLinuxSystem { ... } { ... };
   ```

### Adding a New Module

#### For NixOS modules:
1. Create file in appropriate `modules/nixos/` subdirectory
2. Import in `hosts/<hostname>/default.nix`

#### For home-manager modules:
1. Create file in appropriate `modules/home-manager/` subdirectory
2. Import in `modules/home-manager/default.nix`

## Design Philosophy

This configuration follows these principles:

1. **Modularity**: Each module handles a specific concern
2. **Reusability**: Modules can be mixed and matched across hosts
3. **Separation**: System-level (NixOS) and user-level (home-manager) configs are separated
4. **Host-specific**: Host configurations import only needed modules
5. **Declarative**: All configuration is version-controlled and reproducible

## State Versions

- **NixOS**: 25.05 (flake.nix:37)
- **Home Manager**: 25.05 (flake.nix:58)

## License

This is a personal configuration. Use at your own discretion.
