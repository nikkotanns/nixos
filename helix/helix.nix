{ ... }: {
  programs.helix = {
    enable = true;
    defaultEditor = true;
    themes = {
      theme = builtins.fromTOML (builtins.readFile ./theme.toml);
    };
    languages = {
      language = [
        {
          name = "nix";
          auto-format = true;
        }
        {
          name = "haskell";
          scope = "source.haskell";
          injection-regex = "haskell";
          file-types = [ "hs" ];
          roots = [ "Setup.hs" "stack.yaml" "*.cabal" "cabal.project" "cabal.project.freeze" ];
          comment-token = "--";
          language-servers = [
            "haskell-language-server"
            "haskell-language-server-wrapper"
          ];
          indent = {
            tab-width = 2;
            unit = "  ";
          };
        }
      ];
      language-server.haskell-language-server-wrapper = {
        command = "haskell-language-server-wrapper";
        args = [ "--lsp" ];
      };
      language-server.haskell-language-server = {
        command = "haskell-language-server";
        args = [ "--lsp" ];
      };
    };
    settings = {
      theme = "theme";
      keys.insert = {
        C-i = "normal_mode";
        "C-;" = [ "goto_line_end" "move_char_right" ];

        C-h = "move_char_left";
        C-j = "move_visual_line_down";
        C-k = "move_visual_line_up";
        C-l = "move_char_right";

        C-o = ":write";

      };
      keys.normal = {
        "C-;" = [ "goto_line_end" "move_char_right" ];

        C-i = "insert_mode";

        C-h = "move_char_left";
        C-j = "move_visual_line_down";
        C-k = "move_visual_line_up";
        C-l = "move_char_right";

        C-o = ":write";
      };
      keys.select = {
        "C-;" = [ "goto_line_end" "move_char_right" ];
      };

      editor = {
        color-modes = true;
      };
      editor.cursor-shape = {
        insert = "bar";
        normal = "block";
        select = "underline";
      };
      editor.auto-save = {
        focus-lost = true;
      };
    };
  };
}
