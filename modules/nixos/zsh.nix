{ pkgs, ... }:

{
  users.defaultUserShell = pkgs.zsh;
  environment.shells = with pkgs; [ zsh ];

  programs.zsh = {
    enable = true;
    shellAliases = {
      sync = "nixpush";
      cd = "z";
      xmrig = "xmrig --donate-level 5 -o pool.supportxmr.com:443 -u 48UEoFuv5n9Hweg5JioChG4aX1jXPQtYcKtUqfry2iWe8HgqJHVztPYCqvQD8aX5f6CzG8jcXbkJMFexcKvkTRMsGEyhr5U -k --tls";
      run = "/home/rotted/Scripts/run/target/release/run";
    };
  };
}
