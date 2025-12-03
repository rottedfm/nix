{ pkgs, config, inputs, lib, ... }:

{
  # Noctalia shell - minimal Wayland desktop shell

  # Import noctalia-shell home-manager module
  imports = [
    inputs.noctalia-shell.homeModules.default
  ];

  # Install noctalia-shell and its dependencies
  home.packages = with pkgs; [
    # Noctalia shell package
    inputs.noctalia-shell.packages.${pkgs.system}.default

    # Quickshell (provides the qs command)
    quickshell

    # Core dependencies
    gpu-screen-recorder
    brightnessctl

    # Optional but recommended packages
    cliphist
    cava
    wlsunset
    xdg-desktop-portal
    python3
    evolution-data-server
    kdePackages.polkit-kde-agent-1
  ];
}
