{ ... }:

{
  programs.helix = {
    enable = true;
    settings = {
      theme = "base16_terminal";
      editor.cursor-shape = {
        normal = "block";
        insert = "bar";
        select = "underline";
      };

      editor.file-picker = {
        hidden = false;
      };

      editor = {
        line-number = "relative";
        mouse = false;
      };
    };
  };
}
