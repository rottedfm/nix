{ pkgs, ... }:

{
  programs.git = {
    enable = true;
    settings = {
      user.name = "rotted";
      user.email = "rotted";
    };
  };
 
}
