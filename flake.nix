{
  nixConfig = {
    extra-substituters = [
    ];
    extra-trusted-public-keys = [
    ];
  };

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    typst.url = "github:typst/typst";
    nixpkgs.url = "nixpkgs/nixos-unstable";
  };

  outputs = { self, flake-utils, typst, nixpkgs }@inputs:
    flake-utils.lib.eachDefaultSystem (system:
      let pkgs = nixpkgs.legacyPackages.${system}; in
      {
        devShells.default = pkgs.mkShell {
          # inputsFrom = [ ];
          buildInputs = [
            typst.packages.${system}.default
            pkgs.typst-lsp
          ];
        };
      });
}
