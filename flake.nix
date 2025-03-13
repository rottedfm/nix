# .system/flake.nix

{
  description = "!system!"; 

  inputs = {
    # nixpkgs stable
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    # nixpkgs unstable
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    # home-manager
    home-manager.url = "github:nix-community/home-manager/release-24.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # stylix
    stylix.url = "github:danth/stylix/release-24.11";
  };

  outputs = { self, nixpkgs, home-manager, stylix, ... }@inputs:
    let
      inherit (self) outputs;
      # supported systems
      systems = [ "aarch64-linux" "i686-linux" "x86_64-linix" ];

      forAllSystems = nixpkgs.lib.genAttrs systems;

    in {
      overlays = import ./overlays {inherit inputs; };

      # sudo nixos-rebuild switch --flake .#fm
      nixosConfigurations = {
        fm = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs outputs; };
          modules = [ stylix.nixosModules.stylix ./system/configuration.nix ];
        };
      };

      # home-manager switch --flake .#rotted@fm
      homeConfigurations = {
        "rotted@fm" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.x86_64-linux; # TODO: Make this for all systems
          extraSpecialArgs = { inherit inputs outputs; };
          modules = [ stylix.homeManagerModules.stylix ./user/home.nix ];
        };
      };
    };
}
