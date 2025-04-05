{ pkgs, ... }: {

  services.mako = {
    enable = true;
    font = "JetBrains Mono 14";
    borderColor = "#22DDCCEE";
    backgroundColor = "#000000FF";
    borderSize = 2;
    borderRadius = 6;
    defaultTimeout = 6000;
    padding = "10";
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
