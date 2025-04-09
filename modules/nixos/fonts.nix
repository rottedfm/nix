{ pkgs, ... }:

{
  fonts.packages = with pkgs; [
    noto-fonts-emoji
    noto-fonts-cjk-sans
    nerd-fonts.jetbrains-mono
  ];


  console = {
    font = "ter-v32b";
    earlySetup = true;
      colors = [
        "101010" 
        "e0e0e0" 
        "101010" 
        "e64747" 
        "50fa7b" 
        "ffb86c" 
        "b294bb" 
        "815f8d" 
        "d1afdd" 
        "e0e0e0" 
        "201010" 
        "ff79c6" 
        "50fa7b" 
        "ffb86c" 
        "b294bb" 
        "ffcfff" 
        "d1afdd" 
        "efefef" 
    ];
  };
}

