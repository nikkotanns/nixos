{
  description = "Python development environment with uv";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
      in
      {
        devShells.default = pkgs.mkShell {
          packages = with pkgs; [
            uv
            ruff
          ];
          shellHook = ''
            export LD_LIBRARY_PATH=$NIX_LD_LIBRARY_PATH;

            if [ ! -f pyproject.toml ]; then
              echo "Initializing uv project..."
              uv init --vcs none > /dev/null 2>&1
            fi

            if [ ! -d .venv ]; then
              echo "Creating virtual environment..."
              uv venv > /dev/null 2>&1
            fi
          '';
        };
      }
    );
}
