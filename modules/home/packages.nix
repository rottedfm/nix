{ pkgs, ... }:
{
  # Nix packages to install to $HOME
  #
  # Search for packages here: https://search.nixos.org/packages
  home.packages = with pkgs; [
    # Unix tools
    ripgrep # Better `grep`
    fd
    sd
    tree
    gnumake
    cava
    pass
    eza
    fzf
    glow
    ttyper
    tenki
    neofetch
    cmatrix
    btop
    yt-dlp
    bottom

    # Nix dev
    cachix
    nil # Nix language server
    nix-info
    nixpkgs-fmt

    # monero 
    monero-gui
    monero-cli
    xmrig

    # On ubuntu, we need this less for `man home-configuration.nix`'s pager to
    # work.
    less

    # firefox
    firefox

    # lmms
    lmms
    audacity
    
    # gba emulator
    vbam

    # minecraft
    prismlauncher

    # qbittorrent
    qbittorrent

  ];

  # Programs natively supported by home-manager.
  # They can be configured in `programs.*` instead of using home.packages.
  programs = {
    # Better `cat`
    bat.enable = true;
    # Type `<ctrl> + r` to fuzzy search your shell history
    fzf.enable = true;
    jq.enable = true;
    # Tmate terminal sharing.
    tmate = {
      enable = true;
      #host = ""; #In case you wish to use a server other than tmate.io 
    };
  };
}
