{ config, pkgs, lib, ... }:

{
  # Niri compositor configuration managed via Home Manager
  # This configuration combines the default niri config with DMS keybinds
  # Converted to programs.niri.settings format for stylix compatibility

  programs.niri.settings = {
    # Input configuration
    input = {
      touchpad = {
        tap = false;
        natural-scroll = true;
      };

      mouse = { };

      trackpoint = { };
    };

    # Layout configuration
    layout = {
      gaps = 16;

      center-focused-column = "never";

      preset-column-widths = [
        { proportion = 0.33333; }
        { proportion = 0.5; }
        { proportion = 0.66667; }
      ];

      default-column-width = { proportion = 0.5; };

      focus-ring = {
        width = 4;
      };

      border = {
        enable = true;
        width = 2;
        active.color = config.lib.stylix.colors.withHashtag.base0D;  # stylix accent color
        inactive.color = "rgba(0, 0, 0, 0)";  # transparent for unfocused windows
      };

      struts = {
        left = 0;
        right = 0;
        top = 0;
        bottom = 0;
      };
    };

    # Overview settings
    overview = {
      backdrop-color = "#000000";  # black backdrop
    };

    # Preferences
    prefer-no-csd = true;

    # Screenshot configuration
    screenshot-path = "~/Pictures/Screenshots/Screenshot from %Y-%m-%d %H-%M-%S.png";

    # Spawn programs at startup
    spawn-at-startup = [
      { command = [ "waybar" ]; }
      { command = [ "xwayland-satellite" ]; }
    ];

    # Window rules
    window-rules = [
      {
        # Global rule: apply rounded corners to all windows
        geometry-corner-radius = {
          top-left = 12.0;
          top-right = 12.0;
          bottom-left = 12.0;
          bottom-right = 12.0;
        };
        clip-to-geometry = true;
      }
      {
        # Prevent Kitty from spawning floating and ensure it respects proportion sizing
        matches = [{ app-id = "^kitty$"; }];
        default-column-width = { proportion = 0.5; };
        open-floating = false;
      }
      {
        # Firefox picture-in-picture as floating
        matches = [
          {
            app-id = "firefox";
            title = "^Picture-in-Picture$";
          }
        ];
        open-floating = true;
      }
    ];

    # Keybindings - combining default niri binds + DMS binds
    binds = {
      # Show hotkey overlay
      "Mod+Shift+Slash".action.show-hotkey-overlay = { };

      # DMS Keybinds - Integrated from DankMaterialShell
      "Mod+Alt+N" = {
        action.spawn = [ "dms" "ipc" "night" "toggle" ];
        allow-when-locked = true;
        hotkey-overlay.title = "Toggle Night Mode";
      };

      "Mod+Comma" = {
        action.spawn = [ "dms" "ipc" "settings" "toggle" ];
        hotkey-overlay.title = "Toggle Settings";
      };

      "Mod+M" = {
        action.spawn = [ "dms" "ipc" "processlist" "toggle" ];
        hotkey-overlay.title = "Toggle Process List";
      };

      "Mod+N" = {
        action.spawn = [ "dms" "ipc" "notifications" "toggle" ];
        hotkey-overlay.title = "Toggle Notification Center";
      };

      "Mod+P" = {
        action.spawn = [ "dms" "ipc" "notepad" "toggle" ];
        hotkey-overlay.title = "Toggle Notepad";
      };

      "Mod+Space" = {
        action.spawn = [ "dms" "ipc" "spotlight" "toggle" ];
        hotkey-overlay.title = "Toggle Application Launcher";
      };

      "Mod+V" = {
        action.spawn = [ "dms" "ipc" "clipboard" "toggle" ];
        hotkey-overlay.title = "Toggle Clipboard Manager";
      };

      "Mod+X" = {
        action.spawn = [ "dms" "ipc" "powermenu" "toggle" ];
        hotkey-overlay.title = "Toggle Power Menu";
      };

      "Super+Alt+L" = {
        action.spawn = [ "dms" "ipc" "lock" "lock" ];
        hotkey-overlay.title = "Toggle Lock Screen";
      };

      # DMS Audio controls
      "XF86AudioRaiseVolume" = {
        action.spawn = [ "dms" "ipc" "audio" "increment" "3" ];
        allow-when-locked = true;
      };

      "XF86AudioLowerVolume" = {
        action.spawn = [ "dms" "ipc" "audio" "decrement" "3" ];
        allow-when-locked = true;
      };

      "XF86AudioMute" = {
        action.spawn = [ "dms" "ipc" "audio" "mute" ];
        allow-when-locked = true;
      };

      "XF86AudioMicMute" = {
        action.spawn = [ "dms" "ipc" "audio" "micmute" ];
        allow-when-locked = true;
      };

      # DMS Brightness controls
      "XF86MonBrightnessUp" = {
        action.spawn = [ "dms" "ipc" "brightness" "increment" "5" "" ];
        allow-when-locked = true;
      };

      "XF86MonBrightnessDown" = {
        action.spawn = [ "dms" "ipc" "brightness" "decrement" "5" "" ];
        allow-when-locked = true;
      };

      # Terminal, launcher (using default niri apps)
      "Mod+Return" = {
        action.spawn = [ "kitty" ];
        hotkey-overlay.title = "Open a Terminal: kitty";
      };

      # Overview
      "Mod+O" = {
        action.toggle-overview = { };
        repeat = false;
      };

      # Window management
      "Mod+Q" = {
        action.close-window = { };
        repeat = false;
      };

      # Focus navigation
      "Mod+Left".action.focus-column-left = { };
      "Mod+Down".action.focus-window-down = { };
      "Mod+Up".action.focus-window-up = { };
      "Mod+Right".action.focus-column-right = { };
      "Mod+H".action.focus-column-left = { };
      "Mod+J".action.focus-window-down = { };
      "Mod+K".action.focus-window-up = { };
      "Mod+L".action.focus-column-right = { };

      # Move windows
      "Mod+Ctrl+Left".action.move-column-left = { };
      "Mod+Ctrl+Down".action.move-window-down = { };
      "Mod+Ctrl+Up".action.move-window-up = { };
      "Mod+Ctrl+Right".action.move-column-right = { };
      "Mod+Ctrl+H".action.move-column-left = { };
      "Mod+Ctrl+J".action.move-window-down = { };
      "Mod+Ctrl+K".action.move-window-up = { };
      "Mod+Ctrl+L".action.move-column-right = { };

      # Focus first/last column
      "Mod+Home".action.focus-column-first = { };
      "Mod+End".action.focus-column-last = { };
      "Mod+Ctrl+Home".action.move-column-to-first = { };
      "Mod+Ctrl+End".action.move-column-to-last = { };

      # Focus monitors
      "Mod+Shift+Left".action.focus-monitor-left = { };
      "Mod+Shift+Down".action.focus-monitor-down = { };
      "Mod+Shift+Up".action.focus-monitor-up = { };
      "Mod+Shift+Right".action.focus-monitor-right = { };
      "Mod+Shift+H".action.focus-monitor-left = { };
      "Mod+Shift+J".action.focus-monitor-down = { };
      "Mod+Shift+K".action.focus-monitor-up = { };
      "Mod+Shift+L".action.focus-monitor-right = { };

      # Move to monitors
      "Mod+Shift+Ctrl+Left".action.move-column-to-monitor-left = { };
      "Mod+Shift+Ctrl+Down".action.move-column-to-monitor-down = { };
      "Mod+Shift+Ctrl+Up".action.move-column-to-monitor-up = { };
      "Mod+Shift+Ctrl+Right".action.move-column-to-monitor-right = { };
      "Mod+Shift+Ctrl+H".action.move-column-to-monitor-left = { };
      "Mod+Shift+Ctrl+J".action.move-column-to-monitor-down = { };
      "Mod+Shift+Ctrl+K".action.move-column-to-monitor-up = { };
      "Mod+Shift+Ctrl+L".action.move-column-to-monitor-right = { };

      # Workspace navigation
      "Mod+Page_Down".action.focus-workspace-down = { };
      "Mod+Page_Up".action.focus-workspace-up = { };
      "Mod+U".action.focus-workspace-down = { };
      "Mod+I".action.focus-workspace-up = { };
      "Mod+Ctrl+Page_Down".action.move-column-to-workspace-down = { };
      "Mod+Ctrl+Page_Up".action.move-column-to-workspace-up = { };
      "Mod+Ctrl+U".action.move-column-to-workspace-down = { };
      "Mod+Ctrl+I".action.move-column-to-workspace-up = { };

      # Move workspaces
      "Mod+Shift+Page_Down".action.move-workspace-down = { };
      "Mod+Shift+Page_Up".action.move-workspace-up = { };
      "Mod+Shift+U".action.move-workspace-down = { };
      "Mod+Shift+I".action.move-workspace-up = { };

      # Workspace wheel scrolling
      "Mod+WheelScrollDown" = {
        action.focus-workspace-down = { };
        cooldown-ms = 150;
      };
      "Mod+WheelScrollUp" = {
        action.focus-workspace-up = { };
        cooldown-ms = 150;
      };
      "Mod+Ctrl+WheelScrollDown" = {
        action.move-column-to-workspace-down = { };
        cooldown-ms = 150;
      };
      "Mod+Ctrl+WheelScrollUp" = {
        action.move-column-to-workspace-up = { };
        cooldown-ms = 150;
      };

      # Column wheel scrolling
      "Mod+WheelScrollRight".action.focus-column-right = { };
      "Mod+WheelScrollLeft".action.focus-column-left = { };
      "Mod+Ctrl+WheelScrollRight".action.move-column-right = { };
      "Mod+Ctrl+WheelScrollLeft".action.move-column-left = { };

      "Mod+Shift+WheelScrollDown".action.focus-column-right = { };
      "Mod+Shift+WheelScrollUp".action.focus-column-left = { };
      "Mod+Ctrl+Shift+WheelScrollDown".action.move-column-right = { };
      "Mod+Ctrl+Shift+WheelScrollUp".action.move-column-left = { };

      # Workspace by index
      "Mod+1".action.focus-workspace = 1;
      "Mod+2".action.focus-workspace = 2;
      "Mod+3".action.focus-workspace = 3;
      "Mod+4".action.focus-workspace = 4;
      "Mod+5".action.focus-workspace = 5;
      "Mod+6".action.focus-workspace = 6;
      "Mod+7".action.focus-workspace = 7;
      "Mod+8".action.focus-workspace = 8;
      "Mod+9".action.focus-workspace = 9;
      "Mod+Ctrl+1".action.move-column-to-workspace = 1;
      "Mod+Ctrl+2".action.move-column-to-workspace = 2;
      "Mod+Ctrl+3".action.move-column-to-workspace = 3;
      "Mod+Ctrl+4".action.move-column-to-workspace = 4;
      "Mod+Ctrl+5".action.move-column-to-workspace = 5;
      "Mod+Ctrl+6".action.move-column-to-workspace = 6;
      "Mod+Ctrl+7".action.move-column-to-workspace = 7;
      "Mod+Ctrl+8".action.move-column-to-workspace = 8;
      "Mod+Ctrl+9".action.move-column-to-workspace = 9;

      # Window manipulation
      "Mod+BracketLeft".action.consume-or-expel-window-left = { };
      "Mod+BracketRight".action.consume-or-expel-window-right = { };
      # NOTE: Mod+Comma conflicts with DMS settings toggle - removed default bind
      "Mod+Period".action.expel-window-from-column = { };

      # Column/window sizing
      "Mod+R".action.switch-preset-column-width = { };
      "Mod+Shift+R".action.switch-preset-window-height = { };
      "Mod+Ctrl+R".action.reset-window-height = { };
      "Mod+F".action.maximize-column = { };
      "Mod+Shift+F".action.fullscreen-window = { };
      "Mod+Ctrl+F".action.expand-column-to-available-width = { };

      # Center column
      "Mod+C".action.center-column = { };
      "Mod+Ctrl+C".action.center-visible-columns = { };

      # Width adjustments
      "Mod+Minus".action.set-column-width = "-10%";
      "Mod+Equal".action.set-column-width = "+10%";
      "Mod+Shift+Minus".action.set-window-height = "-10%";
      "Mod+Shift+Equal".action.set-window-height = "+10%";

      # Toggle floating - NOTE: Conflicts with DMS clipboard (Mod+V)
      # "Mod+V" would conflict, so it's assigned to DMS clipboard above
      "Mod+Shift+V".action.switch-focus-between-floating-and-tiling = { };

      # Toggle tabbed column display
      "Mod+W".action.toggle-column-tabbed-display = { };

      # Screenshots
      "Print".action.screenshot = { };
      "Ctrl+Print".action.screenshot-screen = { };
      "Alt+Print".action.screenshot-window = { };

      # System controls
      "Mod+Escape" = {
        action.toggle-keyboard-shortcuts-inhibit = { };
        allow-inhibiting = false;
      };

      "Mod+Shift+E".action.quit = { };
      "Ctrl+Alt+Delete".action.quit = { };
      "Mod+Shift+P".action.power-off-monitors = { };
    };
  };

}
