{ config, pkgs, ... }:

{
  # Slack communication tools
  # Moved from nixos/slack.nix

  home.packages = with pkgs; [
    slack       # Slack desktop client
    slack-term  # Terminal-based Slack client
  ];
}
