{ config, lib, pkgs, ... }:

{
  imports = [
    # firefox
    ./modules/firefox.nix
    # git
    ./modules/git.nix
    # helix
    ./modules/helix.nix
    # hyprland
    ./modules/hyprland.nix
    # kitty
    ./modules/kitty.nix
    # minecraft
    ./modules/minecraft.nix
    # qutebrowser
    ./modules/qutebrowser.nix
    # tofi
    ./modules/tofi.nix
    # stylix
    ./modules/stylix.nix
    # waybar
    ./modules/waybar.nix
    # zellij
    ./modules/zellij.nix
    # zsh 
    ./modules/zsh/zsh.nix
  ];

  # firefox
  firefoxSettings = {
    enable = true;
  };

  # git 
  gitSettings = {
    enable = true;
    userName = "rottedfm";
    userEmail = "rottedfm@proton.me";
  };

  # helix 
  helixSettings = {
    enable = true;
    settings = {
      editor.cursor-shape = {
        normal = "block";
        insert = "bar";
        select = "underline";
      }; 
      editor = {
        line-number = "relative";
        lsp.display-messages = true;
      };
    };
    languages = {
      language-server.rust-analyzer.config.check = {
        command = "clippy";
      };
    };
    packages = [ pkgs.marksman pkgs.unstable.lldb_19 pkgs.rust-analyzer];
  };

  # hyprland
  hyprlandSettings = {
    enable = true;
    settings = {
      exec-once = [ "waybar" ];
      env = [
        "XDG_CURRENT_DESKTOP,Hyprland"
        "XDG_SESSION_TYPE,wayland"
        "XDG_SESSION_DESKTOP,Hyprland"
      ];
      monitor = ",highrr,auto,1";  

      general = {
        gaps_in = 5;
        gaps_out = 20;
        border_size = 2;
        allow_tearing = false;
        layout = "dwindle";
      };

      decoration = {
        rounding = 5;
        inactive_opacity = 0.70;
        blur = {
          enabled = true;
          size = 3;
          passes = 3;
          vibrancy = 0.1696;
        };
      };

      animations = {
        enabled = true;
        bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
      };

      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };

      "$mod" = "SUPER";

      bind = [
        "$mod, Q, exec, kitty"
        "$mod, R, exec, tofi-drun"
        "$mod, C, killactive"
        "$mod, M, exit"

        "$mod, P, pseudo"
        "$mod, V, togglefloating"

        "$mod, H, movefocus, l"
        "$mod, J, movefocus, d"
        "$mod, K, movefocus, u"
        "$mod, L, movefocus, r"

        "$mod SHIFT, H, resizeactive, -20 0"
        "$mod SHIFT, J, resizeactive, 0 20"
        "$mod SHIFT, K, resizeactive, 0 -20"
        "$mod SHIFT, L, resizeactive, 20 0"

        "$mod CTRL, H, swapwindow, l"
        "$mod CTRL, J, swapwindow, d"
        "$mod CTRL, K, swapwindow, u"
        "$mod CTRL, L, swapwindow, r"

      ] ++ (
        builtins.concatLists (builtins.genList(i:
          let ws = i + 1;
          in [
            "$mod, code:1${toString i}, workspace, ${toString ws}"
            "$mod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
          ]) 9)
      );

      binde = [
        "$mod CTRL, H, moveactive, -50 0"
        "$mod CTRL, J, moveactive, 0 50"
        "$mod CTRL, K, moveactive, 0 -50"
        "$mod CTRL, L, moveactive, 50 0"
      ];

      windowrulev2 = [
        "suppressevent maximize, class:.*"
      ];
    };
  };

  # kitty
  kittySettings = {
    enable = true;
    settings = {
      confirm_os_window_close = 0;
      enable_audio_bell = false;
      window_padding_width = 10;
      launch = "zellij";
    };
  };

  # minecraft
  minecraftSettings = {
    enable = true;
  };

  # qutebrowser
  qutebrowserSettings = {
    enable = true;
  };

  # tofi 
  tofiSettings = {
    enable = true;
    settings = {
      width = "100%";
      height = "100%";
      prompt-text = "/launch";
      prompt-padding = 5;
      border-width = 0;
      outline-width = 0;
      padding-left = "35%";
      padding-top = "35%";
      result-spacing = 25;
      num-results = 10;
      drun-launch = true;
      background-color = lib.mkForce "#000A";
      prompt-background = lib.mkForce "#00000000";
      input-background = lib.mkForce "#00000000";
      placeholder-background = lib.mkForce "#00000000";
      default-result-background = lib.mkForce "#00000000";
      alternate-result-background = lib.mkForce "#00000000";
      selection-background = lib.mkForce "#00000000";
    };
  };

  # stylix
  stylixSettings = {
    enable = true;
    wallpaper = ../wallpapers/sakura-wall.png;
    polarity = "dark";
    opacity = {
      desktop = 0.4;
    };
  };
  # waybar 
  waybarSettings = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "bottom";
        spacing = 5;
        height = 36;
        modules-left = [
          "custom/logo"  
          "hyprland/workspaces"
        ];

        modules-center = [ "cava" ];

        modules-right = [
          "pulseaudio"
          "memory"
          "cpu"
          "tray"
          "clock"
        ];

        "custom/logo" = {
          exec = "echo '  '";
        };

        clock = {
          interval = 10;
          format = "  {:%Y-%m-%d %H:%M}";
          tooltip = false;
        };

        cpu = {
          interval = 5;
          tooltip = false;
          format = "  {usage}%";
          format-alt = "  {load}";
          states = {
            warning = 70;
            critical = 90;
          };
        };

        memory = {
          interval = 5;
          format = "  {used:0.1f}G/{total:0.1f}G";
          states = {
            warning = 70;
            critical = 90;
          };
          tooltip = false;
        };

        "hyprland/workspaces" = {
          format = "{icon}";
          format-icons = {
            "1" = "一";
            "2" = "二";
            "3" = "三";
            "4" = "四";
            "5" = "五";
            "6" = "六";
            "7" = "七";
            "8" = "八";
            "9" = "九";
            "10" = "十";
          };
          persistent-workspaces = {
            "*" = 10;
          };
        };

        pulseaudio = {
          format = "{icon} {volume}%";
          format-bluetooth = "{icon} {volume}%";
          format-muted = "  ";
          format-icons = {
            headphone = "  ";
            hands-free = "  ";
            headset = " ";
            phone = " ";
            portable = " ";
            car = " ";
            default = [" " "  "];
          };
          scroll-step = 1;
          tooltip = false;
        };

        cava = {
          framerate = 120;
          autosens = 1;
          bars = 24;
          method = "pulse";
          source = "auto";
          hide_on_silence = true;
          bar_delimiter = 0;
          monstercat = false; 
          waves = false;
          noise_reduction = 0.65;
          input_delay = 2;
          format-icons = [ "▁" "▂" "▃" "▄" "▅" "▆" "▇" "█" ];
        };
      };
    };
  };

  # zellij
  zellijSettings = {
    enable = true;
  };

  # zsh
  zshSettings = {
    enable = true;
    aliases = {
      shutdown = "shutdown now";
      ls = "eza --icons -a --group-directories-first";
      tree = "eza --color=auto --tree";
      dev = "nix develop ~/.system/shell";
    };
    plugins = [
      "zsh-users/zsh-autosuggestions"
      "zsh-users/zsh-syntax-highlighting"
      "romkatv/powerlevel10k"
      "jeffreytse/zsh-vi-mode"
    ];
    zshrc = ''
      source ~/.system/user/modules/zsh/p10k.zsh
    '';
    extraPackages = [ pkgs.noto-fonts-cjk-sans pkgs.eza pkgs.cmatrix pkgs.bottom pkgs.ttyper pkgs.neofetch pkgs.cloc pkgs.pom pkgs.cava ];
  };
}
