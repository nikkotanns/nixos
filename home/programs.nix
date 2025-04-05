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
      theme = "~/.config/nixos/rofi/theme.rasi";
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
