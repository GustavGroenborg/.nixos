{ pkgs, ... }:
pkgs.mkShell.override {
  buildInputs = with pkgs; [
    jdt-language-server
  ];
}
