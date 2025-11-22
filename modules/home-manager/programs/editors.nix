{ config, pkgs, ... }:

{
  # Text editors and viewing tools
  # Moved from nixos/core/system.nix

  home.packages = with pkgs; [
    glow       # Markdown viewer for the terminal
    rust-analyzer  # Rust LSP server
    lldb       # LLDB debugger for Rust
    vscode-extensions.vadimcn.vscode-lldb  # CodeLLDB adapter
  ];

  programs.helix = {
    enable = true;
    settings = {
      editor = {
        line-number = "relative";
        lsp.display-messages = true;
        file-picker = {
          hidden = false;
        };
        cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "underline";
        };
      };
    };
    languages = {
      language-server.rust-analyzer = {
        config = {
          check = {
            command = "clippy";
          };
          inlayHints = {
            bindingModeHints.enable = false;
            closingBraceHints.minLines = 10;
            closureReturnTypeHints.enable = "with_block";
            discriminantHints.enable = "fieldless";
            lifetimeElisionHints.enable = "skip_trivial";
            typeHints.hideClosureInitialization = false;
          };
        };
      };

      language = [{
        name = "rust";
        auto-format = true;
        debugger = {
          name = "lldb-vscode";
          transport = "stdio";
          command = "${pkgs.vscode-extensions.vadimcn.vscode-lldb}/share/vscode/extensions/vadimcn.vscode-lldb/adapter/codelldb";
          args = ["--port" "13000"];
          port-arg = "--port {}";
          templates = [
            {
              name = "binary";
              request = "launch";
              completion = [
                { name = "binary"; completion = "filename"; }
              ];
              args = {
                program = "{0}";
                runInTerminal = true;
              };
            }
          ];
        };
      }];
    };
  };
}
