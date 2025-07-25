{
  description = "NixOS configuration";

  inputs = {
    ###    NIXPKGS     ###
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    nixos-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    ###  HOME MANAGER  ###
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    ###    NIX ALIEN   ###
    nix-alien.url = "github:thiagokokada/nix-alien";

    ###     STYLIX     ###
    stylix.url = "github:danth/stylix/release-25.05";
  };

  outputs = inputs @ { nixpkgs, nixos-unstable, home-manager, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; config.allowUnfree = true; };
      unstable = import nixos-unstable { inherit system; config.allowUnfree = true; };
      args = {
        inherit inputs;
        inherit pkgs;
        inherit unstable;
        lib = pkgs.lib;
      };
    in
    {
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {

        inherit system;
        specialArgs = args;

        modules = [
          ./configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.nikkotanns = import ./home.nix args;
          }
          inputs.stylix.nixosModules.stylix
        ];
      };
    };
}
