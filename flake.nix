{
  inputs = {
    # Principle inputs (updated by `nix run .#update`)
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    flake-parts.url = "github:hercules-ci/flake-parts";
    nixos-unified.url = "github:srid/nixos-unified";
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
