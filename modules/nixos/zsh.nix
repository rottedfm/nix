{ pkgs, ... }:

{
  users.defaultUserShell = pkgs.zsh;
  environment.shells = with pkgs; [ zsh ];

  programs.zsh = {
    enable = true;
    shellAliases = {
      sync = "nixpush";
      cd = "z";
      swww = "swww";
    };
  };
}
