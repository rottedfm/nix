{ config, lib, pkgs, ... }:

{
  options.ollamaSettings = {
    enable = lib.mkEnableOption "Enable ollama for the system.";
    acceleration = lib.mkOption {
      type = lib.types.enum [ "rocm" "cuda" ];
      default = "rocm";
      description = "Set the which gpu driver to use for ollama acceleration.";
    };
  };

  config = lib.mkIf config.ollamaSettings.enable (
    lib.mkMerge [
      (lib.mkIf (config.ollamaSettings.acceleration == "rocm") {
        services.ollama = {
          enable = true;
          package = pkgs.unstable.ollama;
          acceleration = "rocm";
        };
      })

      (lib.mkIf (config.ollamaSettings.acceleration == "cuda") {
        services.ollama = {
          enable = true;
          package = pkgs.unstable.ollama;
          acceleration = "cuda";
        };
      })
    ]
  );
}
