{ pkgs, ... }:

{
  programs.bash = {
    enable = true;
    enableCompletion = true;

    shellAliases = {
      usb = "sudo usb_modeswitch -v 0bda -p 1a2b -K";
    };
  };
  # Zoxide - smarter cd command
  programs.zoxide = {
    enable = true;
    enableBashIntegration = true;
  };

  # HSTR - history search
  programs.hstr = {
    enable = true;
    enableBashIntegration = true;
  };

  # Oh My Posh prompt
  programs.oh-my-posh = {
    enable = true;
    enableBashIntegration = true;
    useTheme = "darkblood";
  };

  # Yazi - terminal file manager
  programs.yazi = {
    enable = true;
    enableBashIntegration = true;
    settings = {
      manager = {
        show_hidden = true;
        sort_by = "natural";
      };
    };
  };
}
