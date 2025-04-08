
{ flake, pkgs, ... }:

{
  imports = [
    flake.inputs.niri-flake.homeModules.niri
  ];

  home.packages = [ pkgs.swww ];

  programs.niri = {
    enable = true;
    config = ''

spawn-at-startup "swww-daemon"
spawn-at-startup "swww img ~/.nix/wallpapers/pink-dream.jpg"
  
screenshot-path "~/Media/Pictures/Schreenshots/%Y-%m-%d %H-%M-%S.png"

window-rule {
  draw-border-with-background false
}

hotkey-overlay {
  skip-at-startup
}

environment {
  QT_QPA_PLATFORM "wayland"
  DISPLAY null
}

layout {

  focus-ring {
    off
    width 6
    active-color "#ff79c6" 
  }

  border {
    off
  }


  tab-indicator {
    off
  }


}



binds {
  Mod+Q { spawn "kitty"; }
  Mod+V { spawn "librewolf"; }

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
