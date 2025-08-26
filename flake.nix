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

    ### Prism Launcher ###
    prismc.url = "github:Diegiwg/PrismLauncher-Cracked";
    prismc.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs @ { nixpkgs, nixos-unstable, home-manager, prismc, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; config.allowUnfree = true; };
      unstable = import nixos-unstable { inherit system; config.allowUnfree = true; };
    in
    {
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {

        inherit system;
        specialArgs = { inherit inputs unstable; };

        modules = [
          ./configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = { inherit inputs unstable; };
            home-manager.users.nikkotanns = import ./home.nix;
          }
          inputs.stylix.nixosModules.stylix
          ({ ... }: {
            nix.settings.substituters = [
              "https://cache.nixos.org"
              "https://prismlauncher.cachix.org"
            ];
            nix.settings.trusted-public-keys = [
              "prismlauncher.cachix.org-1:9/n/FGyABA2jLUVfY+DEp4hKds/rwO+SCOtbOkDzd+c="
            ];
            environment.systemPackages = [
              prismc.packages.x86_64-linux.default
            ];
          })
        ];
      };
    };
}
