{ config, pkgs, ... }:

{
  programs.claude-code.enable = true;

  home.packages = with pkgs; [
    gemini-cli
  ];
}
