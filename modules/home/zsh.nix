{ pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    initExtra = ''
function swww() {
  if ! pgrep -x "swww-daemon" > /dev/null; then
    swww init
    sleep 1
  fi

  swww img "~/.nix/wallpapers/pink-dream.jpg"
}

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
