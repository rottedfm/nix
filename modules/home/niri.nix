{ flake, pkgs, ... }:

let
  base16 = builtins.fromJSON (builtins.readFile (pkgs.runCommand "base16-caroline" {
    buildInputs = [ pkgs.yj ];
  } ''
    yj -yj < ${pkgs.base16-schemes}/share/themes/caroline.yaml > $out
  ''));
in
{
  imports = [
    flake.inputs.niri-flake.homeModules.niri
  ];

  programs.niri = {
    enable = true;
    config = ''

layout {
  border = {
    width 4
    active-gradient {
      from "${base16.base08}"
      to "${base16.base0D}"
      angle 45
    }
    inactive-gradient {
      from "${base16.base08}"
      to "${base16.base0D}"
      angle 45
    }
  }

  focus-ring {
    width 4
    active-gradient {
      from "${base16.base08}"
      to "${base16.base0D}"
      angle 45
    }
    inactive-gradient {
      from "${base16.base08}"
      to "${base16.base0D}"
      angle 45
    }
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
