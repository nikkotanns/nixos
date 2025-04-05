{ pkgs, inputs, ... }: {
  programs.firefox = {
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
      };
      extensions = [
        inputs.firefox-addons.packages.${pkgs.system}.bitwarden
      ];
      userChrome = builtins.readFile ./userChrome.css;
    };
  };
}
