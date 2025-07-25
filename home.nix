{ pkgs, unstable, inputs, ... } @ args:
{
  home.username = "nikkotanns";
  home.homeDirectory = "/home/nikkotanns";

  stylix.targets = {
    rofi.enable = false;
    helix.enable = false;
    gtk.enable = false;
    mako.enable = false;
    qt.enable = false;
    firefox.profileNames = [ "nikkotanns" ];
  };

  stylix.polarity = "dark";

  imports = [
    (import ./firefox/firefox.nix args)
    ./helix/helix.nix

    (import ./home/packages.nix args)
    (import ./home/programs.nix args)
    (import ./home/other.nix args)
  ];

  home.stateVersion = "25.05";
}
