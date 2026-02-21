{ pkgs }:

pkgs.mkShellNoCC {
  packages = with pkgs; [
    ghc
    cabal-install
    haskell-language-server
  ];
}
