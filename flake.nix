{
  nixConfig = {
    extra-substituters = [
      "https://aspiwack.cachix.org"
    ];
    extra-trusted-public-keys = [
      "aspiwack.cachix.org-1:2D/Nc4rGV10LY8O+c3HMbOJ4wtMY6w7xFubjEmexcfc="
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
            pkgs.just
          ];
        };
      });
}
