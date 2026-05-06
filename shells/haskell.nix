{ pkgs }:

pkgs.mkShell {
  packages = with pkgs; [
    ghc
    cabal-install
    haskell-language-server
  ];
}
