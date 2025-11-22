{ config, pkgs, ... }:

{
  # Create helper scripts for GPU switching
  home.packages = [
    # Script to run applications with NVIDIA GPU
    (pkgs.writeShellScriptBin "nvidia-run" ''
      if [ $# -eq 0 ]; then
        echo "Usage: nvidia-run <command> [args...]"
        echo "Example: nvidia-run glxinfo | grep 'OpenGL renderer'"
        exit 1
      fi

      # NVIDIA PRIME offload environment variables
      export __NV_PRIME_RENDER_OFFLOAD=1
      export __NV_PRIME_RENDER_OFFLOAD_PROVIDER=NVIDIA-G0
      export __GLX_VENDOR_LIBRARY_NAME=nvidia
      export __VK_LAYER_NV_optimus=NVIDIA_only

      # Additional NVIDIA environment variables for better compatibility
      export VK_ICD_FILENAMES=/run/opengl-driver/share/vulkan/icd.d/nvidia_icd.x86_64.json

      exec "$@"
    '')

    # Script to check current GPU mode
    (pkgs.writeShellScriptBin "gpu-status" ''
      echo "=== supergfxctl Status ==="
      ${pkgs.supergfxctl}/bin/supergfxctl -g
      echo ""
      echo "=== Active GPUs ==="
      ${pkgs.mesa-demos}/bin/glxinfo | grep "OpenGL renderer"
      echo ""
      echo "=== GPU Information ==="
      echo "NVIDIA GPU:"
      ${pkgs.pciutils}/bin/lspci | grep -i "vga.*nvidia" || echo "  Not found/active"
      echo "AMD GPU:"
      ${pkgs.pciutils}/bin/lspci | grep -i "vga.*amd" || echo "  Not found/active"
      echo ""
      echo "To monitor GPU processes, run: gpu-monitor"
    '')

    # Wrapper for nvtop with proper configuration
    (pkgs.writeShellScriptBin "gpu-monitor" ''
      # Check if user is in video group
      if ! groups | grep -q video; then
        echo "Warning: You may need to be in the 'video' group for full GPU monitoring."
        echo "Add yourself with: sudo usermod -a -G video $USER"
        echo ""
      fi

      # Run nvtop with both AMD and NVIDIA support
      exec ${pkgs.nvtopPackages.full}/bin/nvtop "$@"
    '')

    # Script to switch to integrated GPU mode
    (pkgs.writeShellScriptBin "gpu-integrated" ''
      echo "Switching to integrated GPU mode (AMD only)..."
      ${pkgs.supergfxctl}/bin/supergfxctl -m Integrated
      echo "GPU mode changed. You may need to restart some applications."
    '')

    # Script to switch to hybrid mode
    (pkgs.writeShellScriptBin "gpu-hybrid" ''
      echo "Switching to hybrid GPU mode (AMD + NVIDIA on-demand)..."
      ${pkgs.supergfxctl}/bin/supergfxctl -m Hybrid
      echo "GPU mode changed. Use 'nvidia-run <app>' to run apps on NVIDIA."
    '')

  ];

  # Add shell aliases for convenience
  programs.bash.shellAliases = {
    gpu = "gpu-status";
    nv = "nvidia-run";
    nvmon = "gpu-monitor";
  };
}
