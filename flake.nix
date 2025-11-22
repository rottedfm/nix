{
  inputs = {
    # Principle inputs (updated by `nix run .#update`)
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    flake-parts.url = "github:hercules-ci/flake-parts";
    nixos-unified.url = "github:srid/nixos-unified";

    # Niri compositor
    niri.url = "github:sodiboo/niri-flake";
    niri.inputs.nixpkgs.follows = "nixpkgs";

    # Stylix theming system
    stylix.url = "github:danth/stylix";
    stylix.inputs.nixpkgs.follows = "nixpkgs";

    # DankMaterialShell dependencies
    dgop.url = "github:AvengeMedia/dgop";
    dgop.inputs.nixpkgs.follows = "nixpkgs";

    dms-cli.url = "github:AvengeMedia/danklinux";
    dms-cli.inputs.nixpkgs.follows = "nixpkgs";

    dankMaterialShell.url = "github:AvengeMedia/DankMaterialShell";
    dankMaterialShell.inputs.nixpkgs.follows = "nixpkgs";
    dankMaterialShell.inputs.dgop.follows = "dgop";
    dankMaterialShell.inputs.dms-cli.follows = "dms-cli";    
  };

  outputs = inputs@{ self, ... }:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" "aarch64-linux" ];
      imports = [ inputs.nixos-unified.flakeModules.default ];

      flake =
        let
          myUserName = "rotted";
        in
        {
          # Configurations for Linux (NixOS) machines
          nixosConfigurations."fm" =
            self.nixos-unified.lib.mkLinuxSystem
              { home-manager = true; }
              {
                nixpkgs.hostPlatform = "x86_64-linux";
                imports = [
                  # Host-specific configuration
                  ./hosts/fm

                  # Import niri module
                  inputs.niri.nixosModules.niri

                  # Import stylix module for system-wide theming
                  inputs.stylix.nixosModules.stylix

                  # Setup home-manager in NixOS config
                  {
                    # Explicitly configure home-manager to use system pkgs
                    home-manager.useGlobalPkgs = true;
                    home-manager.useUserPackages = true;

                    home-manager.users.${myUserName} = {
                      imports = [
                        # Our home-manager modules
                        self.homeModules.default
                      ];
                      home.stateVersion = "25.05";
                    };

                    # Pass inputs to home-manager
                    home-manager.extraSpecialArgs = { inherit inputs; };
                  }
                ];
              };

          # Shared home-manager configuration
          homeModules.default = ./modules/home-manager;
        };
    };
}
