{
  description = "Nix project template";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
  };

  outputs = {
    self,
    nixpkgs,
    ...
  }: let
    projectName = "nix-template";
    supportedSystems = [
      "x86_64-linux"
      "aarch64-darwin"
    ];
    forSystems = systems: f:
      nixpkgs.lib.genAttrs systems
      (system: f system (import nixpkgs {inherit system;}));
    forAllSystems = forSystems supportedSystems;
  in {
    formatter = forAllSystems (system: pkgs: pkgs.alejandra);

    devShells = forAllSystems (system: pkgs: {
      default = pkgs.mkShell {
        buildInputs = with pkgs; [
          # python
          python312
          python312Packages.pytest
          python312Packages.python-lsp-server
          rye
          ruff
          ruff-lsp

          # raku
          rakudo

          # koka
          koka

          # janet
          janet
          jpm
        ];
      };
    });
  };
}
