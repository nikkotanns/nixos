{
  description = "Python development environment with uv for pulumi";

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
            pulumi-bin
            pulumiPackages.pulumi-python
          ];
          shellHook = ''
            export LD_LIBRARY_PATH=$NIX_LD_LIBRARY_PATH;

            if [ ! -f pyproject.toml ]; then
              echo "Initializing uv project..."
              uv init --vcs none --bare > /dev/null 2>&1
              uv add pulumi "setuptools<80.0.0" > /dev/null 2>&1
              touch __main__.py
            fi

            if [ ! -d .venv ]; then
              echo "Creating virtual environment..."
              uv venv > /dev/null 2>&1
              uv sync > /dev/null 2>&1
            fi

            if [ ! -d ".pulumi-state" ]; then
              mkdir -p .pulumi-state
              pulumi stack init dev > /dev/null 2>&1 || true
            fi
          '';

        };
      }
    );
}
