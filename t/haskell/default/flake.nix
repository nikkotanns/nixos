{
  description = "Haskell default flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
        haskellPackages = pkgs.haskell.packages.ghc912;

        myProject = haskellPackages.developPackage {
          root = ./.;
          name = "default";
          modifier = drv: pkgs.haskell.lib.dontCheck (pkgs.haskell.lib.dontHaddock drv);
        };
      in
      {
        packages.default = myProject;

        devShells.default = pkgs.mkShell {
          shell = pkgs.zsh;
          buildInputs = [
            pkgs.haskell.compiler.ghc912
            pkgs.cabal-install
            haskellPackages.haskell-language-server
            pkgs.hlint
            pkgs.fourmolu
          ];
        };
      });
  nixConfig = {
    extra-substituters = [
      "https://cache.nixos.org/"
      "https://nix-community.cachix.org"
    ];
    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
    allow-import-from-derivation = "true";
  };

}
