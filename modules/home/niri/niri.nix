
{ flake, pkgs, ... }:

{
  imports = [
    flake.inputs.niri-flake.homeModules.niri
  ];

  home.packages = [ pkgs.swww pkgs.bc pkgs.wl-clipboard pkgs.wayland-utils ];

  programs.niri = {
    enable = true;
    package = pkgs.niri-unstable;
    config = ''

spawn-at-startup "swww-daemon"
spawn-at-startup "swww img ~/.nix/wallpapers/black-minimal.gif"
spawn-at-startup "exec mako"
  
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
  GDK_BACKEND "wayland"
  SDL_VIDEODRIVER "wayland"
  CLUTTER_BACKEND "wayland"
}

layout {
  gaps 32

  focus-ring {
    active-gradient from="#50fa7b" to="#ff79c6" angle=45 
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
  Mod+Control+M { quit skip-confirmation=true; }

  Mod+H { focus-column-left; }
  Mod+J { focus-window-down; }
  Mod+K { focus-window-up; }
  Mod+L { focus-column-right; }

  Mod+R { set-column-width "33%"; }

  Mod+F { set-column-width "100%"; }

  Mod+S { screenshot-screen; }
  Mod+Shift+S { screenshot-window; }

  Mod+P { power-off-monitors; }

  Mod+Shift+H { move-column-left; }
  Mod+Shift+J { move-window-down; }
  Mod+Shift+K { move-window-up; }
  Mod+Shift+L { move-column-right; }

  Mod+Control+H { set-column-width "-5%"; }
  Mod+Control+L { set-column-width "+5%"; }
  Mod+Control+J { set-window-height "-5%"; }
  Mod+Control+K { set-window-height "+5%"; }

  Mod+Comma { consume-window-into-column; }
  Mod+Period { expel-window-from-column; }
}
    '';
  };
}
