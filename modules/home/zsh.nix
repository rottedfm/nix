{ pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    initExtra = ''

function nixpush() {
  local repo="$HOME/.nix"
  if [[ ! -d "$repo/.git" ]]; then
    echo "Not a git repository: $repo"
    return 1
  fi

  cd "$repo" || return

  git add .
  git commit -m "Auto-commit: $(date '+%Y-%m-%d %H:%M:%S')" && git push

  nix run $repo#activate
}

function minecraft_wayland() {
  export GDK_BACKEND=wayland
  export SDL_VIDEODRIVER=wayland
  export QT_QPA_PLATFORM=wayland
  export LIBGL_ALWAYS_SOFTWARE=0
  export MESA_NO_ERROR=1
  export _JAVA_AWT_WM_NONREPARENTING=1
  export WLR_NO_HARDWARE_CURSORS=1

  # Unset LD_PRELOAD to avoid corrupting context creation
  unset LD_PRELOAD

  # Run Minecraft without forcing glfw preload
  portablemc start fabric:1.21.1 --jvm-args="-Xmx16G" "$@"
}

   '';
    antidote = {
      enable = true;
      package = pkgs.antidote;
      plugins = [
        "jeffreytse/zsh-vi-mode"
        "zdharma-continuum/fast-syntax-highlighting"
        "zsh-users/zsh-completions"
        "zsh-users/zsh-autosuggestions"
      ];
    };
  };
}
