{ lib, config, pkgs, ... }:

{
  options.gpuSettings = {
    enable = lib.mkEnableOption "Enable GPU configuration.";
    driver = lib.mkOption {
      type = lib.types.enum [ "NVIDIA" "AMD" ];
      default = "AMD";
      description = "Choose which GPU driver to enable: 'nvidia' or 'amd'.";
    };
  };

  config = lib.mkIf config.gpuSettings.enable (
    lib.mkMerge [
      (lib.mkIf (config.gpuSettings.driver == "nvidia") {
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

      (lib.mkIf (config.gpuSettings.driver == "amd") {
        boot.initrd.kernelModules = [ "amdgpu" ];
        services.xserver.videoDrivers = [ "amdgpu" ];
      })
    ]
  );
}
