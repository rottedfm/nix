{ ... }:

{
  programs.qutebrowser = {
    enable = true;

    settings = {
      colors = {
        completion = {
          fg = "#e0e0e0";  # base05
          bg = "#101010";  # base00
          category = {
            fg = "#ffcfff";    # base07
            bg = "#201010";    # base01
            border = {
              top = "#201010";
              bottom = "#201010";
            };
          };
          item = {
            selected = {
              fg = "#101010";    # base00
              bg = "#b294bb";    # base0D
              border = {
                top = "#b294bb";
                bottom = "#b294bb";
              };
            };
          };
          scrollbar = {
            fg = "#b294bb";  # base0D
            bg = "#31182d";  # base02
          };
        };

        downloads = {
          bar.bg = "#101010";  # base00
          start.fg = "#101010";  # base00
          start.bg = "#50fa7b";  # base0B
          stop.fg = "#101010";   # base00
          stop.bg = "#b294bb";   # base0D
          error.fg = "#e64747";  # base08
        };

        hints = {
          fg = "#101010";   # base00
          bg = "#ffcfff";   # base07
          match.fg = "#e64747";  # base08
        };

        keyhint = {
          fg = "#d1afdd";   # base0C
          bg = "#101010";   # base00
          suffix.fg = "#ffcfff";  # base07
        };

        messages = {
          error = {
            fg = "#e0e0e0";  # base05
            bg = "#e64747";  # base08
          };
          warning = {
            fg = "#101010";  # base00
            bg = "#ffb86c";  # base09
          };
          info = {
            fg = "#50fa7b";  # base0B
            bg = "#101010";  # base00
          };
        };

        prompts = {
          fg = "#e0e0e0";   # base05
          bg = "#101010";   # base00
          border = "#d1afdd";  # base0C
        };

        statusbar = {
          normal = {
            fg = "#e0e0e0";   # base05
            bg = "#101010";   # base00
          };
          insert = {
            fg = "#101010";
            bg = "#50fa7b";
          };
          passthrough = {
            fg = "#101010";
            bg = "#ffcfff";
          };
          private = {
            fg = "#ffcfff";
            bg = "#201010";
          };
          command = {
            fg = "#50fa7b";
            bg = "#101010";
          };
          url = {
            fg = "#b294bb";         # base0D
            success.http = "#50fa7b";  # base0B
            success.https = "#50fa7b"; # base0B
            warn = "#ffb86c";       # base09
            error = "#e64747";      # base08
            hover = "#ffcfff";      # base07
          };
        };

        tabs = {
          bar.bg = "#101010";      # base00
          selected.even = {
            fg = "#101010";
            bg = "#ffcfff";
          };
          selected.odd = {
            fg = "#101010";
            bg = "#ffcfff";
          };
          even.bg = "#201010";
          odd.bg = "#31182d";
        };
      };
    };
  };
}
