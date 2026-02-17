{
  outputs = { nixpkgs }:
    let
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
    in {
      devShells.x86_64-linux.haskell = pkgs.mkShell {
        packages = with pkgs; [
          ghc
          cabal-install
          haskell-language-server
        ];
      };
    };
}
