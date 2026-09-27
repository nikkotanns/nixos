{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    nixos-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-alien = {
      url = "github:thiagokokada/nix-alien";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:danth/stylix/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ { nixpkgs, nixos-unstable, home-manager, ... }:
    let
      system = "x86_64-linux";

      # Overlay для PrismLauncher Cracked
      prismlauncher-overlay = final: prev: {
        prismlauncher-cracked = final.stdenv.mkDerivation rec {
          pname = "prismlauncher-cracked";
          version = "11.0.3";

          src = final.fetchurl {
            url = "https://github.com/Diegiwg/PrismLauncher-Cracked/releases/download/v${version}/PrismLauncher-${version}.tar.gz";
            # ЗАМЕНИТЕ ЭТОТ ХЕШ НА ТОТ, ЧТО ВЫДАСТ NIX ПРИ ПЕРВОЙ СБОРКЕ
            sha256 = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=";
          };

          nativeBuildInputs = [ final.autoPatchelfHook ];

          buildInputs = with final; [
            qt6.qtbase
            qt6.qtsvg
            qt6.qtwayland
            libglvnd
            xorg.libX11
            xorg.libxcb
            zlib
            openssl
            udev
          ];

          installPhase = ''
            runHook preInstall
            
            mkdir -p $out/bin $out/share/prismlauncher
            cp -r ./* $out/share/prismlauncher/
            
            # Создаем wrapper для корректного запуска
            makeWrapper $out/share/prismlauncher/PrismLauncher $out/bin/prismlauncher-cracked \
              --prefix LD_LIBRARY_PATH : "${final.lib.makeLibraryPath buildInputs}" \
              --set QT_QPA_PLATFORM xcb
            
            runHook postInstall
          '';

          meta.mainProgram = "prismlauncher-cracked";
        };
      };

      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
        overlays = [ prismlauncher-overlay ];
      };

      unstable = import nixos-unstable {
        inherit system;
        config.allowUnfree = true;
      };
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
        ];
      };
    };
}
