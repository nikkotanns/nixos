{ config, pkgs, unstable, inputs, ... } @ args:
{
  home.username = "nikkotanns";
  home.homeDirectory = "/home/nikkotanns";

  imports = [
    (import ./home/packages.nix args)
    (import ./home/programs.nix args)
    (import ./home/other.nix args)
  ];

  home.stateVersion = "25.05";
}
