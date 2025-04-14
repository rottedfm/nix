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

  export __GLX_VENDOR_LIBRARY_NAME=mesa
  export LIBGL_ALWAYS_INDIRECT=0
  export GALLIUM_DRIVER=radeonsi
  export LIBGL_DRI3_DISABLE=0
  export MESA_LOADER_DRIVER_OVERRIDE=radeonsi

  local glfw_path
  glfw_path=$(nix eval --raw nixpkgs#glfw-wayland)/lib/libglfw.so.3

  if [[ -f "$glfw_path" ]]; then
    export LD_PRELOAD="$glfw_path"
  else
    echo "Failed to locate glfw-wayland lib, skipping LD_PRELOAD."
  fi

  portablemc start fabric:1.21.1 --jvm-args="-Xmx12G" "$@"
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
