{ pkgs, ... }: {

  stylix.targets = {
    rofi.enable = false;
    helix.enable = false;
    gtk.enable = false;
    mako.enable = false;
    qt.enable = false;
    firefox.profileNames = [ "nikkotanns" ];
  };

  services.mako = {
    enable = true;
    settings = {
      font = "JetBrains Mono 14";
      border-color = "#22DDCCEE";
      background-color = "#000000FF";
      border-size = 2;
      border-radius = 6;
      default-timeout = 6000;
      padding = "10";
    };
  };
  services.wpaperd = {
    enable = true;
    settings = {
      default = {
        path = "~/wallpapers/";
        queue-size = 100;
        initial-transition = false;
      };
    };
  };

  gtk = {
    enable = true;
    cursorTheme = {
      name = "phinger-cursors-dark";
      package = pkgs.phinger-cursors;
      size = 20;
    };

    theme = {
      name = "Blackout";
    };

    iconTheme = {
      name = "adwaita-icon-theme";
      package = pkgs.adwaita-icon-theme;
    };
  };

  qt = {
    enable = true;
    platformTheme.name = "gtk";
    style.name = "Blackout";
  };

  xdg.enable = true;
  xdg.desktopEntries.prismlauncher = {
    name = "Prism Launcher";
    exec = "prismlauncher-cracked";
    terminal = false;
    type = "Application";
    categories = [ "Game" ];
  };
}
