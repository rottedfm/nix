{ pkgs, ... }:

{
  programs.bash = {
    enable = true;
    enableCompletion = true;

    # Enable vi mode for bash
    initExtra = ''
      set -o vi

      # Add padding before prompt (append to preserve oh-my-posh hook)
      _add_padding() { echo; }
      PROMPT_COMMAND="_add_padding;$PROMPT_COMMAND"
    '';
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
