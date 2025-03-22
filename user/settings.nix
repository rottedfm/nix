{config, lib, pkgs, ... }:
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
            # stylix
            ./modules/stylix.nix
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
                env = [
                    "XDG_CURRENT_DESKTOP,Hyprland"
                    "XDG_SESSION_TYPE,wayland"
                    "XDG_SESSION_DESKTOP,Hyprland"
                ];
                monitor = ",highrr,auto,1";

                general = {
                    gaps_in = 5;
                    gaps_out = 20;
                    border_size = 3;
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
               dev = "nix develop ~/.nix/shell";
           };
           plugins = [
               "zsh-users/zsh-autosuggestions"  
               "zsh-users/zsh-syntax-highlighting"
               "romkatv/powerlevel10k"
               "jeffreytse/zsh-vi-mode"
           ];
           zshrc = ''
            source ~/.nix/user/modules/zsh/p10k.zsh
           '';
           extraPackages = [ pkgs.noto-fonts-cjk-sans pkgs.eza pkgs.cmatrix pkgs.bottom pkgs.ttyper pkgs.neofetch pkgs.cloc pkgs.pom pkgs.cava ];
        };
    }
    