{ config, lib, pkgs, ... }:

{
  # Enable OpenGL
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  # NVIDIA drivers configuration
  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    # Use the open source kernel module (RTX 4050 is Ada Lovelace generation)
    # Open source drivers are recommended for newer GPUs
    open = true;

    # Enable the Nvidia settings menu
    nvidiaSettings = true;

    # Use the production branch driver
    package = config.boot.kernelPackages.nvidiaPackages.stable;

    # Enable PRIME offload for hybrid graphics
    prime = {
      offload = {
        enable = true;
        enableOffloadCmd = true;
      };

      # Bus IDs verified with lspci:
      # c4:00.0 = NVIDIA RTX 4050 = PCI:196:0:0
      # c5:00.0 = AMD Radeon 890M = PCI:197:0:0
      amdgpuBusId = "PCI:197:0:0";
      nvidiaBusId = "PCI:196:0:0";
    };

    # Enable power management (helps with battery life)
    powerManagement = {
      enable = true;
      finegrained = true;
    };

    # Modesetting is required for most wayland compositors
    modesetting.enable = true;
  };

  # ASUS supergfxctl for advanced GPU switching
  services.supergfxd = {
    enable = true;
    settings = {
      # Start in integrated mode (AMD only)
      mode = "Integrated";

      # Automatically switch to integrated when on battery
      gfx_vfio_enable = false;

      # Don't restart on mode switch
      always_reboot = false;

      # Don't use vfio
      no_logind = false;
    };
  };

  # Workaround for supergfxctl to detect graphics card
  systemd.services.supergfxd.path = [ pkgs.pciutils ];

  # Add asusctl for additional ASUS laptop features
  services.asusd = {
    enable = true;
    enableUserService = true;
  };

  # Add user to video and render groups for GPU access (needed for nvtop and GPU monitoring)
  # Note: Replace 'rotted' with your username if different
  users.users.rotted.extraGroups = [ "video" "render" ];

  # Install useful GPU tools
  environment.systemPackages = with pkgs; [
    nvtopPackages.full  # GPU monitoring for both AMD and NVIDIA
    mesa-demos          # OpenGL info (includes glxinfo)
    vulkan-tools        # Vulkan utilities
    asusctl             # ASUS laptop control
    supergfxctl         # GPU switching control
    pciutils            # For lspci command
  ];
}
