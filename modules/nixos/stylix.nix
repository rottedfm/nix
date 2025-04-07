{ flake, pkgs, ... }:


{
  imports = [ flake.inputs.stylix.nixosModules.stylix ];
  
  stylix.enable = true;

  stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/caroline.yaml";

  stylix.image = ../../wallpapers/icy-minimal.jpg;
  stylix.imageScalingMode = "fit";

  stylix.fonts = {
    serif = {
      package = pkgs.dejavu_fonts;
      name = "DejaVu Serif";
    };

    sansSerif = {
      package = pkgs.dejavu_fonts;
      name = "DejaVu Sans";
    };

    monospace = {
      package = pkgs.nerd-fonts.fira-code;
      name = "Fira Code Mono Nerd";
    };

    emoji = {
      package = pkgs.noto-fonts-emoji;
      name = "Noto Color Emoji";
    };
  }; 
}

