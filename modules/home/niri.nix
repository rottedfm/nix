{ flake, ... }:

{
  imports = [ flake.inputs.niri-flake.homeModules.niri ];

  programs.niri = {
    enable = true;
    config = ''
binds {
  Mod+Q { spawn "kitty"; }
  Mod+V { spawn "qutebrowser"; }
  
  
  Mod+C { close-window; }
  Mod+M { quit skip-confirmation=true; }

  Mod+H { focus-column-left; }
  Mod+J { focus-window-down; }
  Mod+K { focus-window-up; }
  Mod+L { focus-column-right; }

  Mod+SHIFT+H { move-column-left; }
  Mod+SHIFT+J { move-window-down; }
  Mod+SHIFT+K { move-window-up; }
  Mod+SHIFT+L { move-column-right; } 
}
    '';
  };
}
