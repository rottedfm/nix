{
  description = "!system! with Home Manager, Stylix, and DevShell";

  inputs = {
    # Stable nixpkgs
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";

    # Unstable nixpkgs
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    # Home Manager
    home-manager.url = "github:nix-community/home-manager/release-24.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # Stylix theming
    stylix.url = "github:danth/stylix/release-24.11";

    # Rust overlay
    rust-overlay.url = "github:oxalica/rust-overlay";

    # Utility helpers
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = inputs@{ self, nixpkgs, nixpkgs-unstable, home-manager, stylix, rust-overlay, flake-utils, ... }:
    let
      overlays = import ./overlays { inherit inputs; };
    in flake-utils.lib.eachSystem [ "x86_64-linux" "aarch64-linux" "i686-linux" ] (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          overlays = [
            (import rust-overlay)
          ];
        };

        rust = pkgs.rust-bin.stable.latest.default.override {
          targets = [ "x86_64-unknown-linux-musl" ];
        };
      in {
        # `nix develop` shell
        devShells.default = pkgs.mkShell {

          shellHook = '''
            exec zsh
          ''';
          buildInputs = [
            rust
            pkgs.rust-analyzer
            pkgs.rustfmt
            pkgs.clippy
            pkgs.lldb_19
            pkgs.bacon
            pkgs.openssl
            pkgs.xdotool

            (pkgs.python3.withPackages(p: with p; [
              rich
            ]))
          ];

          RUST_BACKTRACE = "1";
          RUST_SRC_PATH = "${rust}/lib/rustlib/src/rust/library";
        };
      }) // {

      # Global overlays available to all systems
      overlays = overlays;

      # NixOS configuration for system `fm`
      nixosConfigurations = {
        fm = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs outputs; };
          modules = [
            stylix.nixosModules.stylix
            ./system/configuration.nix
          ];
        };
      };

      # Home Manager configuration for user `rotted@fm`
      homeConfigurations = {
        "rotted@fm" = home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs {
            system = "x86_64-linux"; # Update if needed per system
          };
          extraSpecialArgs = { inherit inputs outputs; };
          modules = [
            stylix.homeManagerModules.stylix
            ./user/home.nix
          ];
        };
      };
    };
}

