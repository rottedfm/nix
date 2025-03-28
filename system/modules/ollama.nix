{ config, lib, pkgs, ... }:

{
  options.ollamaSettings = {
    enable = lib.mkEnableOption "Enable ollama for the system.";
    acceleration = lib.mkOption {
      type = lib.types.enum [ "NVIDIA" "AMD" "NONE" ];
      default = "NONE";
      description = "Choose GPU type for Ollama acceleration: 'NVIDIA', 'AMD', or 'NONE'.";
    };
  };

  config = lib.mkIf config.ollamaSettings.enable (
    lib.mkMerge [
      (lib.mkIf (config.ollamaSettings.acceleration == "AMD") {
        services.ollama = {
          enable = true;
          package = pkgs.unstable.ollama;
          acceleration = "rocm";
        };
      })

      (lib.mkIf (config.ollamaSettings.acceleration == "NVIDIA") {
        services.ollama = {
          enable = true;
          package = pkgs.unstable.ollama;
          acceleration = "cuda";
        };
      })

      (lib.mkIf (config.ollamaSettings.acceleration == "NONE") {
        services.ollama.enable = true;
      })
    ]
  );
}
