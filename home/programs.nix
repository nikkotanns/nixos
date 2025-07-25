{ ... }: {
  programs = {
    git = {
      enable = true;
      userName = "nikkotanns";
      userEmail = "nikkotanns@gmail.com";
    };
    kitty = {
      enable = true;
      settings = {
        confirm_os_window_close = 0;
      };
      keybindings = {
        "ctrl+=" = "change_font_size all +2.0";
        "ctrl+-" = "change_font_size all -2.0";
      };
      shellIntegration.enableZshIntegration = true;
    };
    uv = {
      enable = true;
    };
    nushell = {
      enable = true;
      environmentVariables = {
        config = {
          buffer_editor = "hx";
          show_banner = false;
        };
        EDITOR = "hx";
      };
    };
    helix = {
      enable = true;
      defaultEditor = true;
      themes = {
        theme = builtins.fromTOML (builtins.readFile ./themes/helix/theme.toml);
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
    zsh = {
      enable = true;
      enableCompletion = true;
      oh-my-zsh.enable = true;
    };
    starship = {
      enable = true;
      enableZshIntegration = true;
      settings = {
        add_newline = false;
        character.success_symbol = "[!λ>](bold green)";
      };
    };
    carapace = {
      enable = true;
      enableZshIntegration = true;
    };
    zoxide = {
      enable = true;
      enableZshIntegration = true;
    };
    yazi = {
      enable = true;
      enableNushellIntegration = true;
    };
    fzf = {
      enable = true;
      enableZshIntegration = true;
    };
    bat.enable = true;
    zellij = {
      enable = true;
      # enableZshIntegration = true;
    };
    direnv = {
      enable = true;
      enableNushellIntegration = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
      config = {
        global = {
          hide_env_diff = true;
        };
      };
    };
    rofi = {
      enable = true;
      theme = "~/.config/nixos/home/themes/rofi/theme.rasi";
    };
    # Pdf viewer
    zathura = {
      enable = true;
      options = {
        recolor = true;
        guioptions = "none";
      };
      extraConfig = ''
        map j feedkeys "<C-Down>"
        map k feedkeys "<C-Up>"
      '';
    };
    # Image viewer
    feh.enable = true;
    home-manager.enable = true;

  };

}
