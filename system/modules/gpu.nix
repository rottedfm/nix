{ lib, config, pkgs, ... }:

{
  options.gpuSettings = {
    enable = lib.mkEnableOption "Enable GPU configuration.";
    driver = lib.mkOption {
      type = lib.types.enum [ "NVIDIA" "AMD" "NONE" ];
      default = "NONE";
      description = "Choose GPU driver: 'NVIDIA', 'AMD', or 'NONE' for no explicit GPU config.";
    };
  };

  config = lib.mkIf config.gpuSettings.enable (
    lib.mkMerge [
      (lib.mkIf (config.gpuSettings.driver == "NVIDIA") {
        services.xserver.videoDrivers = [ "nvidia" ];

        hardware.graphics.enable = true;
        hardware.nvidia = {
          modesetting.enable = true;
          powerManagement.enable = false;
          powerManagement.finegrained = false;
          open = false;
          nvidiaSettings = true;
          package = config.boot.kernelPackages.nvidiaPackages.stable;
          prime = {
            offload = {
              enable = true;
              enableOffloadCmd = true;
            };
            intelBusId = "PCI:0:2:0";
            nvidiaBusId = "PCI:0:1:0";
          };
        };
      })

      (lib.mkIf (config.gpuSettings.driver == "AMD") {
        boot.initrd.kernelModules = [ "amdgpu" ];
        services.xserver.videoDrivers = [ "amdgpu" ];
      })

      (lib.mkIf (config.gpuSettings.driver == "NONE") {
        # No GPU-specific settings applied
      })
    ]
  );
}
