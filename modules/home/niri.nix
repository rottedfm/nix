{ flake, ... }:

{
  imports = [
    flake.inputs.niri-flake.homeModules.niri
  ];

  programs.niri = {
    enable = true;
    config = ''

layout {
  border {
    width 6
    active-gradient from="#ffcfff" to="#d1afdd" angle=45 relative-to="workspace-view"
    inactive-gradient from="#31182d" to="#201010" angle=45 relative-to="workspace-view" in="srgb-linear"
  }

  focus-ring {
    off
  }

  
}

binds {
  Mod+Q { spawn "kitty"; }
  Mod+V { spawn "qutebrowser"; }

  Mod+C { close-window; }
  Mod+M { quit skip-confirmation=true; }

  Mod+H { focus-column-left; }
  Mod+J { focus-window-down; }
  Mod+K { focus-window-up; }
  Mod+L { focus-column-right; }

  Mod+R { focus-column-first; }
  Mod+F { fullscreen-window; }

  Mod+S { screenshot-screen; }
  Mod+Shift+S { screenshot-window; }

  Mod+P { power-off-monitors; }

  Mod+Shift+H { move-column-left; }
  Mod+Shift+J { move-window-down; }
  Mod+Shift+K { move-window-up; }
  Mod+Shift+L { move-column-right; }

  Mod+Comma { consume-window-into-column; }
  Mod+Period { expel-window-from-column; }
}
    '';
  };
}
