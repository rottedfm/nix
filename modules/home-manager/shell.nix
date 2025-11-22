{ pkgs, ... }:

{
  programs.bash = {
    enable = true;
    enableCompletion = true;

    shellAliases = {
      update = ''
        echo -e "\n\033[1;36m╔════════════════════════════════════════╗\033[0m"
        echo -e "\033[1;36m║\033[0m  \033[1;35m⚡ NixOS Configuration Update\033[0m    \033[1;36m║\033[0m"
        echo -e "\033[1;36m╚════════════════════════════════════════╝\033[0m\n"

        echo -e "\033[1;33m[1/5]\033[0m \033[1;34m🔧 Activating configuration...\033[0m"
        if nix run .#activate; then
          echo -e "\033[1;32m✓\033[0m Configuration activated successfully\n"
        else
          echo -e "\033[1;31m✗\033[0m Failed to activate configuration\n"
          return 1
        fi

        echo -e "\033[1;33m[2/5]\033[0m \033[1;34m📋 Checking changes...\033[0m"
        if git diff --quiet; then
          echo -e "\033[1;33m⚠\033[0m No changes detected\n"
        else
          echo -e "\033[1;32m✓\033[0m Changes found:\n"
          git diff --stat --color=always
          echo ""
        fi

        echo -e "\033[1;33m[3/5]\033[0m \033[1;34m📦 Staging changes...\033[0m"
        git add .
        echo -e "\033[1;32m✓\033[0m All changes staged\n"

        echo -e "\033[1;33m[4/5]\033[0m \033[1;34m💾 Creating commit...\033[0m"
        if git commit -m "Update configuration"; then
          echo -e "\033[1;32m✓\033[0m Commit created successfully\n"
        else
          echo -e "\033[1;33m⚠\033[0m Nothing to commit\n"
        fi

        echo -e "\033[1;33m[5/5]\033[0m \033[1;34m🚀 Pushing to remote...\033[0m"
        if git push; then
          echo -e "\033[1;32m✓\033[0m Pushed to remote successfully\n"
        else
          echo -e "\033[1;31m✗\033[0m Failed to push to remote\n"
          return 1
        fi

        echo -e "\033[1;36m╔════════════════════════════════════════╗\033[0m"
        echo -e "\033[1;36m║\033[0m  \033[1;32m✨ Update completed successfully! ✨\033[0m  \033[1;36m║\033[0m"
        echo -e "\033[1;36m╚════════════════════════════════════════╝\033[0m\n"
      '';
    };

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
