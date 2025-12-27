{
  description = "Julia flake for the AOC2025";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = {
    self,
    nixpkgs,
  }: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in {
    devShells.${system}.default =
      pkgs.mkShell
      {
        buildInputs = [
          # Nix compiled julia (possibly cached)
          (pkgs.julia-bin.withPackages
            [
              "ProgressMeter" # why not?
              # "DataStructures"

              # lsp related:
              "LanguageServer"
              "SymbolServer"
              "StaticLint"
            ])
        ];

        shellHook = ''
          echo "Julia-AOC2025 flake activated"
        '';
      };
  };
}
