{ pkgs, ... }: {

  stylix.targets = {
    rofi.enable = false;
    helix.enable = false;
    gtk.enable = false;
    mako.enable = false;
    qt.enable = false;
    firefox.profileNames = [ "nikkotanns" ];
  };

  stylix.polarity = "dark";


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

  gtk = {
    enable = true;
    cursorTheme = {
      name = "capitaine-cursors";
      package = pkgs.capitaine-cursors;
      size = 24;
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
}
