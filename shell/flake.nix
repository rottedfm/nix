{
  description = "dev-shell";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    rust-overlay.url = "github:oxalica/rust-overlay";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, rust-overlay, flake-utils, ...}:
    flake-utils.lib.eachDefaultSystem (system:
      let
        overlays = [ (import rust-overlay) ];
        pkgs = import nixpkgs {
          inherit system overlays;
        };
      in
      {
        devShells.default = pkgs.mkShell {
          buildInputs = [
            pkgs.openssl
            pkgs.rustfmt
            pkgs.rust-analyzer
            pkgs.lldb_19
            pkgs.bacon
            pkgs.clippy
            pkgs.rustc
            pkgs.xdotool
            pkgs.libxkbcommon
            pkgs.rust-bin.beta.latest.default
            pkgs.xorg.libxcb
            pkgs.dbus
          ];
          nativeBuildInputs = [
            pkgs.autoreconfHook
            pkgs.pkg-config
          ];

          shellHook = ''
            exec zsh
          '';
        };      
      }
    );
}
