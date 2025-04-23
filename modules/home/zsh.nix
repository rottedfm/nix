{ pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    initExtra = ''    

if [[ -z $WAYLAND_DISPLAY ]] && [[ $(tty) == /dev/tty1 ]]; then
  exec dbus-run-session niri
fi

if [[ -z $WAYLAND_DISPLAY ]] && [[ $(tty) == /dev/tty2 ]]; then
  export WLR_NO_HARDWARE_CURSORS=1
  export GAMESCOPE_COLORSPACE=srgb
  export GAMESCOPE_DISPLAY_REFRESH=100
fi



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
