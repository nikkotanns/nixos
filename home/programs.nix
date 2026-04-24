{ pkgs, unstable, ... }: {
  programs = {
    git = {
      enable = true;
      user.name = "nikkotanns";
      user.email = "nikkotanns@gmail.com";
      settings = {
        init = {
          defaultBranch = "master";
        };
      };
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
    aider-chat = {
      enable = true;
      settings = {
        message-file = "~/.config/nixos/config/.aider.custom-rules.md";
        chat-language = "russian";
        auto-commits = true;
        dark-mode = true;
        cache-prompts = true;
        gitignore = true;
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
    # zellij = {
    #   enable = true;
    #   # enableZshIntegration = true;
    # };
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
    onlyoffice = {
      enable = true;
    };
    # Image viewer
    feh.enable = true;
    firefox = {
      enable = true;
      profiles.nikkotanns = {
        isDefault = true;
        name = "nikkotanns";
        settings = {
          # Disable bookmarks toolbar
          "browser.toolbars.bookmarks.visibility" = "never";

          # Sync Setting
          "services.sync.engine.addons" = true;
          "services.sync.engine.addresses" = false;
          "services.sync.engine.bookmarks" = true;
          "services.sync.engine.creditcards" = false;
          "services.sync.engine.history" = true;
          "services.sync.engine.passwords" = false;
          "services.sync.engine.prefs" = true;
          "services.sync.engine.tabs" = true;

          # For userChrome.css
          "toolkit.legacyUserProfileCustomizations.stylesheets" = true;

          # Disable full screen warning 
          "full-screen-api.warning.timeout" = 0;

          # Disable about:config warning
          "browser.aboutConfig.showWarning" = false;

          # Disable "Always offer to translate"
          "browser.translations.automaticallyPopup" = false;

          # Disable "Ask to save passwords"
          "signon.rememberSignons" = false;

          # Disable "Welcome to firefox" on first run
          "trailhead.firstrun.didSeeAboutWelcome" = false;
          "browser.aboutwelcome.enabled" = false;
          "datareporting.policy.firstRunURL" = "";

          # Toolbar config
          "browser.uiCustomization.state" = {
            "placements" = {
              "widget-overflow-fixed-list" = [ ];
              "unified-extensions-area" = [
                "ublock0_raymondhill_net-browser-action"
                "jid1-kkzogwgsw3ao4q_jetpack-browser-action"
                "simple-translate_sienori-browser-action"
              ];
              "nav-bar" = [
                "back-button"
                "forward-button"
                "stop-reload-button"
                "fullscreen-button"
                "urlbar-container"
                "zoom-controls"
                "downloads-button"
                "unified-extensions-button"
                "addon_darkreader_org-browser-action"
                "smartproxy_salarcode_com-browser-action"
                "_446900e4-71c2-419f-a6a7-df9c091e268b_-browser-action"
              ];
              "toolbar-menubar" = [ "menubar-items" ];
              "TabsToolbar" = [
                "firefox-view-button"
                "tabbrowser-tabs"
                "new-tab-button"
                "alltabs-button"
              ];
              "vertical-tabs" = [ ];
              "PersonalToolbar" = [ "import-button" "personal-bookmarks" ];
            };
            "seen" = [
              "save-to-pocket-button"
              "developer-button"
              "addon_darkreader_org-browser-action"
              "jid1-kkzogwgsw3ao4q_jetpack-browser-action"
              "smartproxy_salarcode_com-browser-action"
              "_446900e4-71c2-419f-a6a7-df9c091e268b_-browser-action"
              "simple-translate_sienori-browser-action"
              "ublock0_raymondhill_net-browser-action"
            ];
            "dirtyAreaCache" = [
              "nav-bar"
              "vertical-tabs"
              "PersonalToolbar"
              "widget-overflow-fixed-list"
              "unified-extensions-area"
              "toolbar-menubar"
              "TabsToolbar"
            ];
            "currentVersion" = 20;
            "newElementCount" = 5;
          };

          # Disable "comment, highlight" popup in PDF viewer
          "pdfjs.enableHighlightFloatingButton" = false;
        };
        userChrome = builtins.readFile ./themes/firefox/userChrome.css;
      };
    };
    chromium = {
      enable = true;
      package = pkgs.brave;
    };
    waybar = {
      enable = true;
      settings = {
        mainBar = {
          layer = "top";
          position = "top";
          height = 24;
          "modules-left" = [ "hyprland/workspaces" "custom/spotify" ];
          "modules-center" = [ ];
          "modules-right" = [
            "pulseaudio"
            "network"
            "cpu"
            "memory"
            "battery"
            "tray"
            "clock"
          ];

          "hyprland/workspaces" = {
            "disable-scroll" = true;
            "all-outputs" = false;
            format = "{name}";
            "format-icons" = {
              "1:web" = "";
              "2:code" = "";
              "3:term" = "";
              "4:work" = "";
              "5:music" = "";
              "6:docs" = "";
              urgent = "";
              focused = "";
              default = "";
            };
          };

          tray = {
            spacing = 10;
          };

          clock = {
            "format-alt" = "{:%Y-%m-%d}";
          };

          cpu = {
            format = "{usage}% ";
          };

          memory = {
            format = "{}% ";
          };

          battery = {
            bat = "BAT0";
            states = {
              warning = 30;
              critical = 10;
            };
            format = "{capacity}% {icon}";
            "format-icons" = [ "" "" "" "" "" ];
          };

          network = {
            "format-wifi" = "{essid} ({signalStrength}%) ";
            "format-ethernet" = "{ifname}: {ipaddr}/{cidr} ";
            "format-disconnected" = "Disconnected ⚠";
          };

          pulseaudio = {
            format = "{volume}% {icon}";
            "format-bluetooth" = "{volume}% 󰂯";
            "format-muted" = "";
            "format-icons" = {
              headphones = "";
              handsfree = "";
              headset = "";
              phone = "";
              portable = "";
              car = "";
              default = [ "" "" ];
            };
            "on-click" = "pavucontrol";
          };
        };
      };
      style = (builtins.readFile ./themes/waybar/style.css);
    };
    home-manager.enable = true;
  };
}
